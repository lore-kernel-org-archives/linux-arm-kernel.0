From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 11 Sep 2012 12:19:07 +0200
Subject: [PATCH v2 0/3] arm/dts: omap: add dt data for MUSB
In-Reply-To: <1347345381-4390-1-git-send-email-kishon@ti.com>
References: <1347345381-4390-1-git-send-email-kishon@ti.com>
Message-ID: <504F101B.2020804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Beside minor comments and the lack of explicit changelog to explain what
part of the HW you are addressing, this series looks good.

I guess that series should be rebased on top of lo/devel-dt without much
trouble.

On 09/11/2012 08:36 AM, Kishon Vijay Abraham I wrote:
> No major change from the previous version. Just removed the
> omap-usb2 dt data and sent that as a separate patch.

Indeed that one will be trickier to merge properly, so my second thought
is it is better to have it separated.

Regards,
Benoit

> 
> Rebased on
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git musb
> 
> Kishon Vijay Abraham I (3):
>   arm/dts: Add twl6030-usb data
>   arm/dts: Add twl4030-usb data
>   arm/dts: omap: Add usb_otg and glue data
> 
>  arch/arm/boot/dts/omap3-beagle.dts |    6 ++++++
>  arch/arm/boot/dts/omap3-evm.dts    |    6 ++++++
>  arch/arm/boot/dts/omap3.dtsi       |    8 ++++++++
>  arch/arm/boot/dts/omap4-panda.dts  |   10 ++++++++++
>  arch/arm/boot/dts/omap4-sdp.dts    |   10 ++++++++++
>  arch/arm/boot/dts/omap4.dtsi       |    8 ++++++++
>  arch/arm/boot/dts/twl4030.dtsi     |   21 +++++++++++++++++++++
>  arch/arm/boot/dts/twl6030.dtsi     |    5 +++++
>  8 files changed, 74 insertions(+)
> 
