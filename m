From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 19 Sep 2011 18:13:11 -0500
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110915102528.GI6267@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DAED674@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2011 3:25 AM, Russell King wrote:
>
> I'm going to be merging a mach-types update (the cut-down and the
> policy-conforming version) for the next merge window.  This will mean
> that things WILL BREAK, and I will not notice that things have broken.
>
> In order to fix this, entries need to be fixed to conform to the
> requirements - where the machine_is_xxx() name is the same as the
> MACH_TYPE_xxx name and the CONFIG_MACH_xxx name too.
>
> Moreover, entries older than 12 months which have not been merged will
> be removed.  It is not possible to automatically check for machine_is_xxx()
> usages as these could conflict with other architectures, and I'm
> certainly NOT checking for them by hand (I estimate that'd take a
> significant amount of manual effort to do.)  What that means is that it
> is _important_ to get the core platform support in _first_ before any
> drivers which may make use of this.

Russell,

I posted support for MACH_VISION_EP9307 back in March and it's in your
patch tracker as 6851/1.  I assumed it was still there because of the
work to clean up the ARM tree.

Is it possible to still get this patch merged and add the following
back to mach-types:

vision_ep9307		MACH_VISION_EP9307	VISION_EP9307		1578

Thanks,
Hartley
