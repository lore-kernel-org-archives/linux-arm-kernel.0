From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 28 Oct 2016 17:17:24 +0800
Subject: [PATCH 1/1] ARM: dts: imx6ul-14x14-evk: add USB dual-role support
In-Reply-To: <1470128903-942-1-git-send-email-peter.chen@nxp.com>
References: <1470128903-942-1-git-send-email-peter.chen@nxp.com>
Message-ID: <CAL411-p_T9DP61kVJ8yTf3v5tduAgTgPaKa1dBCPDo+RhP7igw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2016 at 5:08 PM, Peter Chen <peter.chen@nxp.com> wrote:
> With commit 851ce932242d ("usb: chipidea: otg: don't wait vbus
> drops below BSV when starts host"), the driver can support
> enabling vbus output without software control, so this board
> (control vbus output through ID pin) can support dual-role now.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul-14x14-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> index e281d50..c5cf942 100644
> --- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
> @@ -225,7 +225,7 @@
>  };
>
>  &usbotg1 {
> -       dr_mode = "peripheral";
> +       dr_mode = "otg";
>         status = "okay";
>  };
>

Ping....


Peter
