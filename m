From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 13 Sep 2012 21:51:27 +0200
Subject: [PATCH V3 1/5] ARM: add infra-structure for BCM2708/BCM2835 and
 Raspberry Pi
In-Reply-To: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120913195125.GA4240@raptus.dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Sep 11, 2012 at 10:18:25PM -0600, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm2708.txt b/Documentation/devicetree/bindings/arm/bcm2708.txt
> new file mode 100644
> index 0000000..49eec61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm2708.txt
> @@ -0,0 +1,15 @@
> +Broadcom BCM2708 device tree bindings
> +-------------------------------------------
> +
> +Boards with the BCM2708 SoC, or another SoC in the BCM2708 family, shall have
> +the following properties:
> +
> +Required root node property:
> +
> +compatible = "broadcom,bcm2708";
> +
> +Boards with BCM2835 SoC shall *additionally* have the following properties:
> +
> +Required root node property:
> +
> +compatible = "broadcom,bcm2835";

Please update also the vendor prefixes index at
Documentation/devicetree/bindings/vendor-prefixes.txt.

BTW is it possible to change it to "bcm"?

Regards,
Domenico 

-----[ Domenico Andreoli, aka cavok
 --[ http://cavokz.wordpress.com/gpgkey/
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
