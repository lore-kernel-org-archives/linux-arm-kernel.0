From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 16 May 2011 12:17:44 -0500
Subject: [PATCH] clocksource: use the correct base address to setup timer 0
In-Reply-To: <20110516171618.GA13659@n2100.arm.linux.org.uk>
References: <201105161008.30604.hartleys@visionengravers.com>
	<20110516171618.GA13659@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269764D2E0E732@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 16, 2011 10:16 AM, Russell King wrote:
> On Mon, May 16, 2011 at 10:08:30AM -0700, H Hartley Sweeten wrote:
>> The static variable clksrc_base was removed by:
>> 
>> commit 3f3808c30612334e38e0641024d2c020c0eda7d4
>> 
>> Use the base address passed to sp804_clocksource_init() when
>> doing the setup for timer 0.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>
> This has already been fixed.

Ok. Thanks for the info.

Hartley
