resource "google_compute_security_policy" "policy" {
     name = "wp-champ-policy"
     project = "wp-champ"
     description = "Cloud Armor Security Policy"
     adaptive_protection_config {
        layer_7_ddos_defense_config {
          enable = true
    }
  }

  deny = {
      action      = "deny(403)"
      priority    = 2000
      description = "Deny pre-configured rule java-v33-stable at sensitivity level 3"
      preview     = true
      expression  = <<-EOT
        evaluatePreconfiguredWaf('java-v33-stable', {'sensitivity': 3})
      EOT
    }
}