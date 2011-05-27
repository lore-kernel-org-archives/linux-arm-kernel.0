From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 08:49:21 -0700
Subject: [PATCH 00/14] GPIO: OMAP: first round of cleanup
In-Reply-To: <20110527032439.GK5032@ponder.secretlab.ca> (Grant Likely's
	message of "Thu, 26 May 2011 21:24:39 -0600")
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
	<20110527032439.GK5032@ponder.secretlab.ca>
Message-ID: <87fwo03zzy.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Grant Likely <grant.likely@secretlab.ca> writes:

> On Fri, May 20, 2011 at 05:14:43PM +0200, Kevin Hilman wrote:
>> Start moving SoC-specific register handling out of the driver by passing
>> in register offsets in via platform data.
>> 
>> Also, move OMAP1 MPUIO IRQ handling over to genric IRQ chip.
>> 
>> Applies on top of Tony's for-next branch (which include's the generic
>> IRQ chip work from tglx) and the OMAP GPIO driver move to
>> drivers/gpio.
>
> Hey Kevin,
>
> If you've got a branch with this series in it and tested, then I'd be
> happy to pull that instead of applying the patches myself.
>

Being very late in the cycle, I'd prefer to save this for 2.6.41.  Let's
just do the move for 2.6.40, and I'll (re)submit this early in the
2.6.41 cycle.  

Thanks,

Kevin
