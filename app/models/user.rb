class User < ApplicationRecord
    validates :name, presence: { message: "El nombre no puede estar vacío" }

    validates :email,
    presence: { message: "El email es obligatorio" },
    uniqueness: { 
      case_sensitive: false, 
      message: "El email ya está registrado",
      conditions: -> { where(deleted: false) }
    },  
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "El email no tiene un formato válido" },
    if: -> { email_changed? }

end