From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:49:04 +0100
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100412184904.GG3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 05:32:18PM -0500, H Hartley Sweeten wrote:
> The ARCH_REQUIRE_GPIOLIB config option will select GPIOLIB which
> in turn will select GENERIC_GPIO.  Because of this, there is no
> reason to do the select GENERIC_GPIO in arch/arm/Kconfig for the
> architectures that have ARCH_REQUIRE_GPIOLIB.

This kind of patch normally causes regular merge conflicts, which
historically have caused a repeated number of headaches - there's
a similar patch for GENERIC_TIME which is pending.

I suggest waiting until we're closer to the merge window than we
are at present; I'll bring my devel stuff to a freeze state before
hand so we can get these two patches merged - maybe around the
-rc7 release.

Please ping me closer to that.
