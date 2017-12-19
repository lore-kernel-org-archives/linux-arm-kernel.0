From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Dec 2017 08:51:25 +0000
Subject: [PATCH V4 21/26] backlight: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
Message-ID: <20171219085125.55qsifnhh7u57ucv@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Dec 2017, Sinan Kaya wrote:

> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-coding the domain as 0.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/apple_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
