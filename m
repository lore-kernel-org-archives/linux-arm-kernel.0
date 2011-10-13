From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 13 Oct 2011 16:25:36 +0100
Subject: [PATCH v5 00/10] Per SoC descriptor
In-Reply-To: <20111013103237.GS21648@n2100.arm.linux.org.uk>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
	<20111013103237.GS21648@n2100.arm.linux.org.uk>
Message-ID: <4E9702F0.4070000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/11 11:32, Russell King - ARM Linux wrote:
> On Mon, Oct 10, 2011 at 03:02:12PM +0100, Marc Zyngier wrote:

[...]

>>  65 files changed, 569 insertions(+), 149 deletions(-)
> 
> This isn't particularly appealing for something that's supposed to
> be a clean up - it's introducing 400+ new lines of code.  It looks like
> most of this comes from the platform stuff rather than core stuff.
> 
> Can't we do any better with this?  We really need things to be going
> in the other direction.

There is definitely room for improvement, by factoring in some common
code across platforms. But I see that as a second phase, and started by
just moving things to the SoC descriptor, all the code staying mostly
the same.

If we agree the method, then I'll start looking at reducing the platform
footprint by offering common methods that plug into the SMP ops.

	M.
-- 
Jazz is not dead. It just smells funny...
