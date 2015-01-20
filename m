From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Jan 2015 14:33:19 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <20150120132613.GJ2938@lunn.ch>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com> <20150116191734.GB31577@lunn.ch>
 <54BE258A.10808@ti.com> <20150120132613.GJ2938@lunn.ch>
Message-ID: <CAMuHMdWAVFsVwGFVkPGBCW9hfStbOeFxF44SESkyw7ta9yXcog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 2:26 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> led-gpio looks like more work, but i don't see why it should not be
> possible. One thing i do need to check is that if the brightness is
> set to 255 the output is not set to 255/256 on and you have a regular

is set to 255/256?

> glitch. For an LED that does not really matter, but for GPIO it would
> not be good.

Indeed.

Gr{oetje,eeting}s,

                        Geert, who had a quick look at the data sheet recently

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
