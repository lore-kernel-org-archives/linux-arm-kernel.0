From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Nov 2017 14:11:01 +0100
Subject: [PATCH 2/2] arm64: dts: renesas: eagle: add I2C0 support
In-Reply-To: <20171116210801.215014557@cogentembedded.com>
References: <20171116210801.215014557@cogentembedded.com>
Message-ID: <CAMuHMdW76avXBqHqjFL7tF4c9LypsYM0zPuo9+muKkiRUMx03Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 10:06 PM, Sergei Shtylyov
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
