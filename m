From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sat, 1 Mar 2014 19:58:30 +0100
Subject: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI
 Connector
In-Reply-To: <20140228163431.GV21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>
 <20140228160612.GR21483@n2100.arm.linux.org.uk>
 <5310B609.1010105@ti.com>
 <20140228163431.GV21483@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 5:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> There's actually three HDMI connectors:
>
>   All three connectors carry all required HDMI signals, including a TMDS
>   link. The Type B connector is slightly larger and carries a second TMDS
>   link, which is necessary to support very high resolution displays using
>   dual link. The Type C connector carries the same signals as the Type A
>   but is more compact and intended for mobile applications.
>
> So, Type C and Type A are electrically the same.

There's also D (e.g. on BeagleBone Black) and E:

http://en.wikipedia.org/wiki/HDMI#Connectors

Electrically they seem to be the same as A/C.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
