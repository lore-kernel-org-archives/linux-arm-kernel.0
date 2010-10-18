From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 18 Oct 2010 15:19:47 +0200
Subject: [PATCH 9/9] arch: arm: fixed typos
In-Reply-To: <AANLkTim8e-PuLa7aG+gPf4R-gPUPgdf5rbBN10YfaoAA@mail.gmail.com>
References: <1287219606-20759-1-git-send-email-andrea.gelmini@gelma.net>
	<20101018080644.GD12363@pengutronix.de>
	<AANLkTim8e-PuLa7aG+gPf4R-gPUPgdf5rbBN10YfaoAA@mail.gmail.com>
Message-ID: <20101018131946.GD12421@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrea,

On Mon, Oct 18, 2010 at 02:54:39PM +0200, Andrea Gelmini wrote:
> 2010/10/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> Hi Uwe,
>    thanks a lot for your answer.
> 
> > [Adding trivial at kernel.org to Cc:]
> 
> Wow! I didn't know trivial at kernel.org. Very interesting. Which is the policy to
> post? I can send simple fix without bothering anyone?

Quoting Documentation/SubmittingPatches:

For small patches you may want to CC the Trivial Patch Monkey
trivial at kernel.org which collects "trivial" patches. Have a look
into the MAINTAINERS file for its current manager.
Trivial patches must qualify for one of the following rules:
 Spelling fixes in documentation
 Spelling fixes which could break grep(1)
 Warning fixes (cluttering with useless warnings is bad)
 Compilation fixes (only if they are actually correct)
 Runtime fixes (only if they actually fix things)
 Removing use of deprecated functions/macros (eg. check_region)
 Contact detail and documentation fixes
 Non-portable code replaced by portable code (even in arch-specific,
 since people copy, as long as it's trivial)
 Any fix by the author/maintainer of the file (ie. patch monkey
 in re-transmission mode)

baruch

> > On Sat, Oct 16, 2010 at 11:00:05AM +0200, Andrea Gelmini wrote:
> > ? ? ? ?http://thread.gmane.org/gmane.linux.kernel/1030436/
> 
> Interesting.
> 
> > Don't know why they didn't appear in the trivial tree yet.
> 
> I guess because the patches are not group by subsystem, maybe.
> Or is allowed to make single traversal-tree commit?

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
