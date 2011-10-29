From: will.deacon@arm.com (Will Deacon)
Date: Sat, 29 Oct 2011 14:58:28 +0100
Subject: [PATCH 33/51] ARM: mach-prima2: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <CAGsJ_4xvOTKwd-A83arN7anNNrdN9NQoaur76izUsa0GCmd=xQ@mail.gmail.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-34-git-send-email-will.deacon@arm.com>
	<CAGsJ_4xvOTKwd-A83arN7anNNrdN9NQoaur76izUsa0GCmd=xQ@mail.gmail.com>
Message-ID: <20111029135827.GB25057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 10:41:09AM +0100, Barry Song wrote:
> 2011/10/28 Will Deacon <will.deacon@arm.com>:
> > This patch updates mach-prima2 to use arm_arch_reset instead of
> > arch_reset.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Hi Will, i guess you can move the arch reset of prima2 to
> arch/arm/mach-prima2/rstc.c instead of creating a new file. rstc is
> the reset controller driver in prima2. so that is the right file to
> place your codes. and you will not need to include system.h as well.

Aha! rstc is a reset controller rather than a dyslexic realtime clock. Thanks,
I'll used that file for v2 if needed.

Will
