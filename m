From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 Nov 2015 09:01:35 +0900
Subject: [PATCH v2] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <1447968823-2159-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
 <1447968823-2159-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <564E62DF.5030407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 06:33, Timo Sigurdsson wrote:
> Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
> framework") moved the the sunxi SID driver to a new framework, but left
> multi_v7_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> instead of the new symbol NVMEM_SUNXI_SID. Hence, re-enable the driver
> in multi_v7_defconfig.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> ---
> Changes in v2:
> - Move the extra cleanup work for multi_v7_defconfig to a separate
>   patch (to be submitted at a later point to avoid conflicts with
>   another patch waiting to be merged)
> ---
>  arch/arm/configs/multi_v7_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Fully satisfies my v1's comments:

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
