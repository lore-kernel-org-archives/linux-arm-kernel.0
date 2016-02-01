From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 01 Feb 2016 18:16:47 +0100
Subject: [PATCH] ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard
 matrix
In-Reply-To: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
References: <1454121504-12683-1-git-send-email-djkurtz@chromium.org>
Message-ID: <2283417.UbYyfQa1E3@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am Samstag, 30. Januar 2016, 10:38:24 schrieb Daniel Kurtz:
> From: James Chao <james_chao@asus.com>
> 
> The LOCK key is at KSO9/KSI3 for Chromebook Flip and other devices
> that use the Chrome OS EC keyboard matrix.
> 
> Signed-off-by: James Chao <james_chao@asus.com>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>

that should probably be a 
	Reviewed-by: YH Huang <yh.huang@mediatek.com>
As I don't see any actual patch handling step by him/her.

Also, you might've included Olof as the keeper of all things ChromeOS when 
sending.

@Olof: this seems to be pretty Veyron-specific for the moment, so I'm inclined 
to pick that up. Please holler if you disagree and want to pick it up yourself 
;-)


Thanks
Heiko

> ---
>  arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> b/arch/arm/boot/dts/cros-ec-keyboard.dtsi index 4e42f30c..c045105 100644
> --- a/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> +++ b/arch/arm/boot/dts/cros-ec-keyboard.dtsi
> @@ -55,6 +55,7 @@
>  			MATRIX_KEY(0x03, 0x04, KEY_F5)
>  			MATRIX_KEY(0x03, 0x06, KEY_6)
>  			MATRIX_KEY(0x03, 0x08, KEY_MINUS)
> +			MATRIX_KEY(0x03, 0x09, KEY_F13)
>  			MATRIX_KEY(0x03, 0x0b, KEY_BACKSLASH)
>  			MATRIX_KEY(0x03, 0x0c, KEY_MUHENKAN)
