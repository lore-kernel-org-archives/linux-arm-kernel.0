From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 23 Oct 2013 11:38:42 +0200
Subject: [PATCH 0/2] ARM: dts: omap5-uevm: Audio related fixes
In-Reply-To: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
References: <1382520740-11197-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <52679922.1050004@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 23/10/2013 11:32, Peter Ujfalusi wrote:
> Hi,
>
> When the omap5-evm.dts file has been renamed to omap5-uevm.dts and the sEVM
> support got deprecated in favor of uEVM (or Panda5) the content was not
> validated.
> The reset GPIO is different on uEVM compared to sEVM and uEVM does not have
> support for dmic.
>
> Regards,
> Peter

I've just applied your series, let's try to push that for 3.13.

Thanks,
Benoit


> ---
> Peter Ujfalusi (2):
>    ARM: dts: omap5-uevm: Correct twl6040 reset GPIO pinmux
>    ARM: dts: omap5-uevm: Remove pinmux for dmic pins
>
>   arch/arm/boot/dts/omap5-uevm.dts | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
>


-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
