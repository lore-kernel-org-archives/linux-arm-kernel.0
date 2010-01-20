From: jamie.iles@picochip.com (Jamie Iles)
Date: Wed, 20 Jan 2010 16:18:08 +0000
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <20100120154250.GA27507@n2100.arm.linux.org.uk>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop>
	<20100120144140.GB22897@n2100.arm.linux.org.uk>
	<20100120150303.GG4089@wear.picochip.com>
	<20100120154250.GA27507@n2100.arm.linux.org.uk>
Message-ID: <20100120161808.GI4089@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 03:42:50PM +0000, Russell King - ARM Linux wrote:
> If you're referring to reading the main CPU ID register and relying
> on the part number telling you what CPU you're running on, that's
> unreliable if you're only checking the part number - you at least
> need to check the implementer.
> 
> If you want to do ID checking via the main ID register, there are
> some clashes even if you take the implementer field into account.
Ok, so for the kernel based code I should check the implementer and part
number then. For now we can make sure that the implementor is ARM and add
others if they have compatible PMUs and hope that there aren't any clashes
with nasty side effects.

Jamie
