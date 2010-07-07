From: david.jander@protonic.nl (David Jander)
Date: Wed, 7 Jul 2010 14:08:50 +0200
Subject: i.MX51 kernel trees: Where to start?
Message-ID: <201007071408.50621.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

I just subscribed to this list, in the hope that I have picked the right place 
to ask questions about linux kernel development for the Freescale i.MX51 SoC. 
If there are better/other places to be for that, I'd be very happy to know.

We are busy designing a new board based on the i.MX51 SoC, that will be 
running linux. This is the first ARM-linux development we are doing, after a 
few powerpc-linux developments.

To aid in design decision-making, we decided to purchase a MX51EVK board and 
investigate the state of linux/bsp/drivers for that platform, so here I am 
with quite a lot of newbie questions and the hope to get some of them answered 
here:

Please forgive me if I am asking something that has been discussed before. I 
have looked at the archives of this list, but did not find good answers.

1.- What's the most recommended (git-) tree to start from doing BSP 
development?
Right now, I am playing with sources downloaded from freescale directly, and 
AFAICS this is quite similar to the "tracking-fsl-imx_2.6.31" branch from denx 
git:

http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/tracking-fsl-
imx_2.6.31

Is this indeed the best place to start? What other trees are there, and how 
can I get an impression of the state of each one? How far are effords for 
mainline inclusion of the freescale patches?

2.- Using this kernel, I notice the touchscreen driver, (mxc_ts.c) not working 
correctly. It looks like it works for a few seconds after boot, and then 
starts delaying samples very much, to the point that it is unusable. Is this a 
known problem? Is there someone working on this? Should I use another driver?

Also, at least libts does not recognize touches as clicks, but merely updates 
the touch coordinates. I have yet to check which kinds of events are generated 
exactly, but it doesn't seem to be correct.


3.- What about the android patches? Is there someone actively working on 
Android on the i.MX51? What's the state of the Android patches from Freescale? 
Are they useable/combineable with current "normal" kernel trees?
We don't have plans currently on using Android, but it seems at least feasible 
that one of our clients might start asking for it....


Best regards,

-- 
David Jander
Protonic Holland.
