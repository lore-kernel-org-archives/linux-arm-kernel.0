From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Feb 2017 19:23:42 +0100
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <20170221181849.GG8605@leverpostej>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
 <20170221110712.GB5021@amd> <de2a15d4-9ac2-9ba9-a47a-eacbf478f601@arm.com>
 <CAMuHMdVmu4AYZ6MZHd79N2-2gELR6s3oZ46UnEszCfLvHymY1w@mail.gmail.com>
 <20170221172012.GD8605@leverpostej>
 <CAMuHMdX_pot+=rJfY1Kor4gYD4CgBYivngzCLwV36LELx+AA5Q@mail.gmail.com>
 <20170221181849.GG8605@leverpostej>
Message-ID: <CAMuHMdUsWTYrUO9JtCDA5J6iPcRJMMevk9XDfiup=NpJKAkMPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 21, 2017 at 7:18 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On top of that, the Linux PM subsystem allows to configure wakeup by writing
>> "enabled" to a device's "wakeup" file in sysfs.  Or you can use ethtool for
>> Wake-on-LAN.
>
> Sure; userspace can always do something silly here.

Not that silly: you can wake up using these sources, but not necessarily from
all states.

> As I mentioned in my other reply, we could/should add an interface to
> allow userspace to determine if it has a guaranteed wakeup, which would
> allow us to do the right thing.

Right.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
