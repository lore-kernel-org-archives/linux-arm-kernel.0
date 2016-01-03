From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 03 Jan 2016 01:54:31 +0100
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <1449782357-22982-1-git-send-email-lho@apm.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
Message-ID: <4133541.hlxbdmvYbG@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 10, 2015 02:19:15 PM Loc Ho wrote:
> Add APM X-Gene ACPI I2C device support. These patches follow
> the same implementation as AMD I2C driver - changes in ACPI APD
> and Designware I2C drivers.
> 
> v2:
> * Spilt the acpi_apd change with defines for AMD and X-Gene I2C's
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
> Loc Ho (2):
>   acpi:apd: Add APM X-Gene ACPI I2C device support
>   i2c:dw: Add APM X-Gene ACPI I2C device support

Both patches applied, thanks!
