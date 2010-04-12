From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 12 Apr 2010 14:01:17 -0500
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <20100412184904.GG3048@n2100.arm.linux.org.uk>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
	<20100412184904.GG3048@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B0270842697636D4B70AD@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 12, 2010 11:49 AM, Russell King wrote:
> On Thu, Apr 01, 2010 at 05:32:18PM -0500, H Hartley Sweeten wrote:
>> The ARCH_REQUIRE_GPIOLIB config option will select GPIOLIB which
>> in turn will select GENERIC_GPIO.  Because of this, there is no
>> reason to do the select GENERIC_GPIO in arch/arm/Kconfig for the
>> architectures that have ARCH_REQUIRE_GPIOLIB.
>
> This kind of patch normally causes regular merge conflicts, which
> historically have caused a repeated number of headaches - there's
> a similar patch for GENERIC_TIME which is pending.
>
> I suggest waiting until we're closer to the merge window than we
> are at present; I'll bring my devel stuff to a freeze state before
> hand so we can get these two patches merged - maybe around the
> -rc7 release.
>
> Please ping me closer to that.

Will do.

I just wanted to get this out there to make sure nobody saw any issues.

I will hold this until around -rc7 as you requested and just collect any
Ack's, etc., that show up.  Eric Miao has already sent an Acked-by that
I will add then.

Regards,
Hartley
