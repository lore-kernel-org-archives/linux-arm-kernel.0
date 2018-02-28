From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 11:52:36 +0100
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: add I2C0 support
In-Reply-To: <f830570f-f7e7-b277-172a-360a20de1aaf@cogentembedded.com>
References: <3aaa4464-fc85-3fb4-2026-5d9df357bdff@cogentembedded.com>
 <f830570f-f7e7-b277-172a-360a20de1aaf@cogentembedded.com>
Message-ID: <CAMuHMdW7Uo+xJ---VeRReWcSvGfc9P0GrwwAAoPK9PW-gVxw=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 9:55 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the Eagle board dependent part of the I2C0 device node.
>
> The I2C0 bus is populated by ON Semiconductor PCA9653 I/O expander and
> Analog Devices ADV7511W HDMI transmitter (but we're only describing the
> former chip now).
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

(lost)
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
