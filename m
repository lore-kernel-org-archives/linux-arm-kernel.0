From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 Dec 2015 11:15:47 +0100
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: use fallback usbhs
 compatibility string
In-Reply-To: <1450404705-5449-2-git-send-email-horms+renesas@verge.net.au>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
 <1450404705-5449-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWhcCE9G2pPALRek+iB=Jot+a6uiO-WnR-Q8OHtTVWQmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 3:11 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -746,7 +746,7 @@
>         };
>
>         hsusb: usb at e6590000 {
> -               compatible = "renesas,usbhs-r8a7790";
> +               compatible = "renesas,usbhs-r8a7790", "renesas,usbhs";

"renesas,rcar-gen2-usbhs", not "renesas,usbhs".



-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
