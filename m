From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 10 May 2010 11:42:08 -0500
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <20100506204305.GB26818@n2100.arm.linux.org.uk>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
	<20100412184904.GG3048@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636D4B70AD@AUSP01VMBX24.collaborationhost.net>
	<20100412191506.GL3048@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636ECB4E08@AUSP01VMBX24.collaborationhost.net>
	<20100506204305.GB26818@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B0270842697636EDF5797@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 06, 2010 1:43 PM, Russell King wrote:
> On Thu, May 06, 2010 at 12:29:34PM -0500, H Hartley Sweeten wrote:
>> -rc7 should be coming soon.  Would you like this patch rebased now or after
>> Linus releases -rc7?  Also, I assume it should be rebased to linux-next or
>> would you prefer it rebased to one of your branches?
>
> Thanks for reminding me.
>
> This time around, there's a number of patches which can only sensibly
> be applied once I've frozen most of the individual branches of my tree,
> and this is one of them.  Essentually, these are:
> - your 'select GPIOLIB' patch
> - killing the 'select GENERIC_TIME' from the ARM Kconfig menus
> - pmu/oprofile patch set
>
> Freezing it before -rc7 is released would be too early, so I think doing
> so shortly after -rc7 (which is due this evening/tonight) would be the
> right time.

Hello Russell,

I see Linus released -rc7 over the weekend.  When will you be freezing your
-devel tree?  I will rebase the 'select GPIOLIB' patch after that.

Regards,
Hartley
