From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jul 2013 14:38:52 +0100
Subject: [PATCH 05/22] ARM: dts: bcm281xx: Remove '0x's from BCM11351 BRT
 DTS file
In-Reply-To: <51ED2D90.4020209@broadcom.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-5-git-send-email-lee.jones@linaro.org>
 <51ED2D90.4020209@broadcom.com>
Message-ID: <20130722133852.GA26801@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Christian Daudt wrote:

> On 13-07-22 03:52 AM, Lee Jones wrote:
> >Cc: Christian Daudt <csd@broadcom.com>
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  arch/arm/boot/dts/bcm11351-brt.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
> >index 67ec524..fdace5d 100644
> >--- a/arch/arm/boot/dts/bcm11351-brt.dts
> >+++ b/arch/arm/boot/dts/bcm11351-brt.dts
> >@@ -27,18 +27,18 @@
> >  		status = "okay";
> >  	};
> >-	sdio0: sdio at 0x3f180000 {
> >+	sdio0: sdio at 3f180000 {
> >  		max-frequency = <48000000>;
> >  		status = "okay";
> >  	};
> >-	sdio1: sdio at 0x3f190000 {
> >+	sdio1: sdio at 3f190000 {
> >  		non-removable;
> >  		max-frequency = <48000000>;
> >  		status = "okay";
> >  	};
> >-	sdio3: sdio at 0x3f1b0000 {
> >+	sdio3: sdio at 3f1b0000 {
> >  		max-frequency = <48000000>;
> >  		status = "okay";
> >  	};
> Hi Lee,
>  Is this convention documented ? Someone called my attention to the
> fact that this dts files was inconsistent in its use of 0x in names,
> but I was not aware of a coding guideline for this.

The best two places I can think of are:

Documentation/devicetree/usage-model.txt
and
http://www.devicetree.org/Device_Tree_Usage

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
