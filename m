From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 27 Mar 2014 16:18:43 +0100
Subject: [PATCH] arm64: Fix duplicated Kconfig entries again
In-Reply-To: <53341ADF.2050904@linaro.org>
References: <1395738060-18489-1-git-send-email-hanjun.guo@linaro.org>
 <5334078A.9010408@arm.com> <53341ADF.2050904@linaro.org>
Message-ID: <2765234.k5FCzWzCDz@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 27, 2014 08:34:39 PM Hanjun Guo wrote:
> On 2014-3-27 19:12, Sudeep Holla wrote:
> > Hi Hanjun,
> > 
> > On 25/03/14 11:09, Hanjun Guo wrote:
> >> Hi Sudeep,
> >>
> >> On 2014-3-25 18:00, Sudeep Holla wrote:
> >>> Hi Hanjun,
> >>>
> >>> On 25/03/14 09:00, Hanjun Guo wrote:
> >>>> After commit 74397174989e5 (arm64: Fix duplicated Kconfig entries),
> >>>> I still get a duplicate Power management options section in linux-next
> >>>> git repo, may be due to some merge conflicts, anyway, fix that in this
> >>>> patch.
> >>>>
> >>> I reported this and Mark Brown posted the patch[1].
> >>> I assumed it is already pulled, but looks like that's not the case.
> >> [...]
> >>> [1] http://www.spinics.net/lists/arm-kernel/msg314472.html
> > 
> > [...]
> > 
> >> here is the link:
> >> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/Kconfig
> >>
> > 
> > Just had a look at the linux-next tree and looks like the original commit:
> > "cpufreq: enable ARM drivers on arm64" is pulled by both Catalin and Rafael
> > which has resulted in the fixup patch[1] not removing the duplicate entry
> > cleanly.
> > 
> > If not too late it better to ask either Rafael or Catalin to drop both patches
> > from their tree, instead of creating 4 patches in total to enable cpufreq :)
> 
> Rafael is on vacation now.
> 
> Catalin, could you please handle this?

Well, not really, I'm at a conference now.

Anyway, I'd rather not drop anything, but if you send me a revert, I can apply it.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
