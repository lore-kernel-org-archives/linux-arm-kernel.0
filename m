From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Wed, 27 Jan 2016 11:02:37 +0100
Subject: [PATCH] ARM: dts: n900: Include adp1653 device
In-Reply-To: <20160121165408.GJ5783@n2100.arm.linux.org.uk>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd> <20160121163857.GH19432@atomide.com>
 <20160121165408.GJ5783@n2100.arm.linux.org.uk>
Message-ID: <20160127100237.GH25796@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 16:54:08 Russell King - ARM Linux wrote:
> On Thu, Jan 21, 2016 at 08:38:57AM -0800, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [160121 02:19]:
> > > On Thu 2016-01-21 09:29:10, Russell King - ARM Linux wrote:
> > > > The merge window is open, which is when development code that was merged
> > > > in good time prior to the merge window is sent upstream to Linus.  Linux
> > > > maintainers may choose not to merge new code into their tree to avoid
> > > > disrupting the utility of linux-next until the merge window has
> > > > closed.
> > > 
> > > Support for new hardware is normally allowed after -rc1.
> > 
> > Yeah most maintainers avoid looking at new code until -rc1. Or until
> > regresssions are out of the way. So patience please. Fixes are
> > welcome any time though.
> 
> Indeed.  However, unlike Pavel's comment, many maintainers choose not
> to merge code for new hardware until the merge window - it's very rare
> that support for new hardware is merged during the -rc phase.
> 
> If it were otherwise, I would've been able to get the Hummingboard 2
> DTS patches in, or the etnaviv team would've been able to get the
> Etnaviv GPU DRM driver in during the 4.4-rc cycle, or the Dove PMU
> driver, or... etc.
> 
> Practically, new code waits for merge windows, because no one wants
> to de-stabilise the progression of the -rc series with new code, and
> Linus wants to see -rc merges fairly quiet and be mostly bug fixes
> so he can feel good about a final release around -rc6 to -rc7 time.
> 

In my opinion this patch is not support for new hardware. It just add
missing DT definition for one specific board for HW which was added to
linux kernel in v4.2-rc1 version. For me it looks like that needed DT
definition was forgotten...

-- 
Pali Roh?r
pali.rohar at gmail.com
