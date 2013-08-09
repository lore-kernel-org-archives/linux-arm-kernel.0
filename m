From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 9 Aug 2013 12:30:20 +0200
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem [OT]
In-Reply-To: <20130809094340.GO23006@n2100.arm.linux.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
Message-ID: <20130809123020.70907621@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Aug 2013 10:43:40 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> Note that we do have another case not yet in tree, which is DRM, but
> this case is different from that, because ASoC can cope with components
> with independent initialisation.

No sure!

Sometimes, with the tda998x in HDMI mode, I get a black screen on my TV
set. And, surprise, when I start the audio (playing something with
vlc), the image appears!

I dumped all (known) registers in the audio and video subsystems
(tda998x, dove lcd, kirkwood audio), and there is no difference between
normal display and black screen. So, some audio event should interact
with the HDMI display.

I don't think that the problem comes from the TV set, because, when
there is a black screen, turning the TV off/on never makes it display
normally again. Rebooting the cubox also lets the black screen.
Only powering off/on the cubox could change the display back to normal.

Now, playing some audio stream gives me immediately a normal display.

Any idea?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
