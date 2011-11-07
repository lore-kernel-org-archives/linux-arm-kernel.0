From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Nov 2011 13:38:47 +0000
Subject: [02: PATCH 0/41] Platform arch_reset changes
In-Reply-To: <20111106173939.GJ12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
Message-ID: <20111107133847.GC5454@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sun, Nov 06, 2011 at 05:39:39PM +0000, Russell King - ARM Linux wrote:
> Part 2. These are the platform updates, so far.
> 
> The first patch combines the individual files in mach-clps711x which
> contain one or two functions or data structures before changing the
> arch_reset stuff.
> 
> The majority of the remaining patches address each group of platforms
> individually.
> 
> The final patch removes the resulting empty arch_reset() functions,
> its call site and associated code.  XXX NOTE XXX This results in
> anything left with an arch_reset() function having non-functional
> restart capability.

I was dreading the thought of having to go digging around in each platform
again, so thanks for doing this. Apart from the troublesome platforms
(partially addressed in your third series), is there anything else that
needs looking at?

I guess I should also ask whether or not the third series is a blocker for
merging the other two (given that it would leave those platforms broken).

Cheers,

Will
