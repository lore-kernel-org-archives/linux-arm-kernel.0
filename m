From: khilman@ti.com (Kevin Hilman)
Date: Wed, 29 Jun 2011 16:30:13 -0700
Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
In-Reply-To: <20110629215423.GI23312@n2100.arm.linux.org.uk> (Russell King's
	message of "Wed, 29 Jun 2011 22:54:23 +0100")
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
	<87mxh0tuk2.fsf@ti.com>
	<20110629180535.GF23312@n2100.arm.linux.org.uk>
	<8762nosbj4.fsf@ti.com>
	<20110629215423.GI23312@n2100.arm.linux.org.uk>
Message-ID: <87wrg4p662.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Jun 29, 2011 at 12:06:07PM -0700, Kevin Hilman wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Wed, Jun 29, 2011 at 10:29:49AM -0700, Kevin Hilman wrote:
>> >> Russell, if you're OK with it, can you add it to your suspend branch for
>> >> the upcoming merge window?
>> >
>> > Yes - though I think we can go a little bit further - this patch is on
>> > top of my code so far, and is untested.  There isn't a need for the
>> > saving of these registers to be in assembly because we can read them
>> > just as easily from C code.
>> 
>> Indeed
>> 
>> > Comments?
>> 
>> Looks good to me (although untested) care to respin on top of $SUBJECT
>> patch?  
>> 
>> Minor comments below...
>
> Done.

Tested-by: Kevin Hilman <khilman@ti.com>

Tested full-chip retention and off on 3430/n900, 3530/Overo and
3630/Zoom3.

Kevin
