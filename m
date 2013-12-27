From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 27 Dec 2013 04:58:48 +0000
Subject: [PATCH v4 1/5] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
In-Reply-To: <1387239401-13918-2-git-send-email-al.stone@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-2-git-send-email-al.stone@linaro.org>
Message-ID: <20131227045848.GB21429@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 05:16:37PM -0700, al.stone at linaro.org wrote:

> +config ACPI_REDUCED_HARDWARE
> +	bool "Hardware-reduced ACPI support"
> +	depends on ARM || ARM64
> +	help
> +	This config adds support for Hardware-reduced ACPI.

Well, that's not really true - most of the hardware-reduced ACPI support 
seems to be built even if this isn't turned on. Maybe 
ACPI_REDUCED_HARDWARE_ONLY ?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
