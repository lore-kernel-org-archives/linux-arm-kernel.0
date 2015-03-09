From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 10 Mar 2015 10:31:01 +1100
Subject: [linux-sunxi] [PATCH 09/15] ARM: dts: sun4i: Add USB Dual Role
 Controller
In-Reply-To: <1425933628-9672-10-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-10-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGRGNgVsf05rtLC2+yOPrbrPV-ceQzPC=ZX1zX+hfNxdC7OX-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Mar 10, 2015 at 7:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a node for the otg/drc usb controller to sun4i-a10.dtsi.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++++++++
>  drivers/usb/musb/Kconfig         |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 8180a3a..fab8e9a 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -65,6 +65,7 @@ comment "Platform Glue Layer"
>  config USB_MUSB_SUNXI
>         tristate "Allwinner (sunxi)"
>         depends on ARCH_SUNXI
> +       depends on NOP_USB_XCEIV

Shouldn't this be in a different patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
