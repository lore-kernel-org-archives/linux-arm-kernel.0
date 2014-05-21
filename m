From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 13:51:20 -0700
Subject: [GIT PULL]]ARM: sirf: machine update for 3.16
In-Reply-To: <CAGsJ_4wxaU5Sz9p3rb8wXuHeFs_kFx7BG-ThdQL0oiLHPqOb9w@mail.gmail.com>
References: <CAGsJ_4yqTkKu+93Fo_D6NaZMyz4T6_EmKz4gZfyeQCi_uF-3dg@mail.gmail.com>
 <CAGsJ_4wD=FqxNeuEs47f0D9V+Qhn8jyUQL67iv4rsZ3r2K_3vA@mail.gmail.com>
 <CAGsJ_4y7gEQd9-Em6LW2kZ79qUOz5dSYzeWnBLbt8o8QsOSA6w@mail.gmail.com>
 <20140520050740.GI18956@quad.lixom.net>
 <CAGsJ_4wxaU5Sz9p3rb8wXuHeFs_kFx7BG-ThdQL0oiLHPqOb9w@mail.gmail.com>
Message-ID: <20140521205120.GA24341@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 01:39:20PM +0800, Barry Song wrote:
> 2014-05-20 13:07 GMT+08:00 Olof Johansson <olof@lixom.net>:
> > On Sun, May 18, 2014 at 08:07:14PM +0800, Barry Song wrote:
> >> >> Bin Shi (2):
> >> >>       clocksource: prima2: fix some minor checkpatch issues
> >> >>       irqchip: sirf: fix one minor checkpatch issue
> >> >>
> >> >> Xianglong Du (1):
> >> >>       ARM: prima2: rstc: fix some minor checkpatch issues
> >> >>
> >> >> Zhiwu Song (2):
> >> >>       clocksource:sirf: remove the hardcode for the clk of timers
> >> >>       clocksource: marco: fix the affinity set for local timer of CPU1
> >> >
> >> > as Daniel has applied this one "clocksource: marco: fix the affinity
> >> > set for local timer of CPU1" to his clk tree, i'll rebuilt the tag by
> >> > dropping this.
> >>
> >> hi Olof,
> >> i did a force update to tags/sirf-soc-for-3.16 after dropping
> >> "clocksource: marco: fix the affinity set for local timer of CPU1"
> >> which has been in clk tree , the new request is as below:
> >>
> >> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> >>
> >>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> >> tags/sirf-soc-for-3.16
> >>
> >> for you to fetch changes up to c7cff54d5926e3f419c23eff2ebaf6f5e12da05d:
> >>
> >>   clocksource:sirf: remove the hardcode for the clk of timers
> >> (2014-05-12 21:43:49 +0800)
> >>
> >> ----------------------------------------------------------------
> >> ARM: sirf: machine update for 3.16
> >>
> >> most of them fix some minor checkpatch issues according to key customers'
> >> requirement. And this patchset also cleanups the clk of clocksource: move
> >> to get clk by dts properity.
> >>
> >
> > Merged into next/cleanup. Thanks.
> 
> Olof,
> i noticed today Daniel Lezcano applied two more clocksource patches
> into his tree for 3.16 after i re-built the sirf-soc-for-3.16 tag. so
> for this pull, there are only two left.
> 
> Bin Shi (2):
>        clocksource: prima2: fix some minor checkpatch issues
> 
> Xianglong Du (1):
>        ARM: prima2: rstc: fix some minor checkpatch issues
> 
> so i did a force push for tags/sirf-soc-for-3.16 again just now
> including only these two.
> 
> very sorry for that!

Don't do this. If you need to add a patch to a branch, then you send us
a revised pull request with the new patch on top. Also, don't just send a reply
with "oh, I added some code". It makes it hard to use the diffstat to tell
whether what I pulled from you was what was supposed to be there and nothing
more (or less).

I have no idea what's in your branch now, nor what is supposed to be there.
What's in our tree now is in our tree -- I suggest you take a look and send an
updated pull request for the incremental contents, with a tag that describes
the new contents (but not the old).


-Olof
