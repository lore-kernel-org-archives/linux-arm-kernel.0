From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 07 Apr 2014 14:21:31 +0200
Subject: [PATCH] ACPI: Update the ownership and developers for ACPI in
 Kconfig
In-Reply-To: <1396528650-7402-1-git-send-email-hanjun.guo@linaro.org>
References: <1396528650-7402-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1487377.07icAKoM8K@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 03, 2014 08:37:30 PM Hanjun Guo wrote:
> The UEFI Forum included the ACPI spec in its portfolio in October 2013
> and will host future spec iterations, following the ACPI v5.0a release.
> 
> A UEFI Forum working group named ACPI Specification Working Group (ASWG)
> has been established to handle future ACPI developments, any UEFI member
> can join the group and contribute to ACPI specification.
> 
> So update the ownership and developers for ACPI in Kconfig accordingly,
> and update the website link to ACPI specification too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index c205653..831e541 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -32,9 +32,10 @@ menuconfig ACPI
>  	  <http://acpica.org/>
>  
>  	  ACPI is an open industry specification co-developed by
> -	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
> +	  ACPI Specification Working Group (ASWG) under UEFI Forum, any
> +	  UEFI member can join ASWG and contribute to ACPI specification.
>  	  The specification is available at:
> -	  <http://www.acpi.info>

The spec is still available from here, so why are you removing this link?

> +	  <http://www.uefi.org/acpi/specs>
>  
>  if ACPI
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
