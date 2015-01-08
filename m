From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 Jan 2015 20:28:45 +0100
Subject: [PATCH v2 0/8] Add Simple Power-Managed Bus Support
In-Reply-To: <1418842153-17113-1-git-send-email-geert+renesas@glider.be>
References: <1418842153-17113-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdVeEmKiqGTOmevaBDbJ=nBTbSi6d6Xrm0eyvbMTtyU=sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 7:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The Renesas Bus State Controller (BSC) provides an external bus for
> connecting multiple external devices to an SoC, driving several chip
> select lines, for e.g. NOR FLASH, Ethernet and USB.
> On the kzm9g and ape6evm development boards, an smsc9220 Ethernet
> controller is connnected to the BSC of an SH-Mobile AG5 (sh73a0) resp.
> R-Mobile APE6 (r8a73a4) SoC.

[...]

> This was tested on sh73a0/kzm9g-multiplatform. Without this, Ethernet
> doesn't work, as the ZB clock is disabled by clk_disable_unused().
> Testing on r8a73a4/ape6evm-multiplatform would be appreciated.

Has anyone tried this on r8a73a4/ape6evm-multiplatform?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
