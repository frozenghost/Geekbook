"""Application configuration."""

from typing import List
import json

from pydantic import Field, computed_field
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings."""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )

    # Database
    database_url: str = Field(
        default="postgresql://postgres:password@localhost:5432/mydatabase",
        description="Database URL",
    )
    test_database_url: str = Field(
        default="postgresql://postgres:password@localhost:5433/testdatabase",
        description="Test database URL",
    )

    # JWT
    secret_key: str = Field(
        default="your-secret-key-here-change-in-production",
        description="Secret key for JWT tokens",
    )
    algorithm: str = Field(default="HS256", description="JWT algorithm")
    access_token_expire_minutes: int = Field(
        default=30, description="Access token expiration time in minutes"
    )

    # CORS
    allowed_origins_env_var: str = Field(
        default="http://localhost:3000,http://127.0.0.1:3000",
        alias="ALLOWED_ORIGINS",
        description="Raw string for allowed CORS origins from .env or default"
    )

    @computed_field(return_type=List[str])
    @property
    def allowed_origins(self) -> List[str]:
        """Parses the allowed_origins_env_var into a list of strings."""
        val = self.allowed_origins_env_var.strip()
        if not val:
            return []

        if val.startswith('[') and val.endswith(']'):
            try:
                loaded_json = json.loads(val)
                if isinstance(loaded_json, list) and all(isinstance(item, str) for item in loaded_json):
                    return loaded_json
            except json.JSONDecodeError:
                pass 
        
        return [origin.strip() for origin in val.split(',') if origin.strip()]

    # OpenAPI
    openapi_output_file: str = Field(
        default="./shared-data/openapi.json",
        description="OpenAPI specification output file",
    )

    # Environment
    environment: str = Field(default="development", description="Environment name")

    @property
    def is_development(self) -> bool:
        """Check if running in development mode."""
        return self.environment.lower() == "development"

    @property
    def is_production(self) -> bool:
        """Check if running in production mode."""
        return self.environment.lower() == "production"


# Global settings instance
settings = Settings() 