From: khilman@ti.com (Kevin Hilman)
Date: Wed, 08 Feb 2012 16:20:28 -0800
Subject: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
In-Reply-To: <20120209001135.GF25414@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 9 Feb 2012 00:11:35 +0000")
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com> <87ty312ae0.fsf@ti.com>
 <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk>
 <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk>
Message-ID: <87ipjgx3g3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> > Does it fix the other issues I mention in the commit log as well?
>> 
>> Like your patches 1 & 5, my series fixes the oops and also makes the
>> error strings simple, non-wrapping ones.
>> 
>> The one thing it doesn't fix is the spelling typo you fixed in the
>> comment, but IMO we can leave that out for -rc.
>
> OK, but it would be much better for that simple fix to go with another
> simple patch.  On its own it doesn't make sense as a commit.

Agreed.  We'll have some other VC/VP cleanup for v3.4, and I'll add this
into that cleanup.

Thanks,

Kevin
