From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2011 20:56:49 +0100
Subject: [PATCH 1/4] AM3517 : support for suspend/resume
In-Reply-To: <1313754927-11992-2-git-send-email-abhilash.kv@ti.com>
References: <1313754927-11992-1-git-send-email-abhilash.kv@ti.com>
	<1313754927-11992-2-git-send-email-abhilash.kv@ti.com>
Message-ID: <20110819195649.GB18947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 05:25:24PM +0530, Abhilash K V wrote:
> 1. Patch to disable dynamic sleep (as it is not supported
>    on AM35xx).
> 2. Imported the unique suspend/resume sequence for AM3517,
>    contained in the new file arch/arm/mach-omap2/sleep3517.S.
> 3. Added omap3517_ to symbol-names in sleep3517.S which are common
>    with sleep34xx.S, and added appropriate checks.

You don't say what kernel these are against, it looks like it is not the
latest mainline kernel, as I cleaned up OMAP3 suspend/resume significantly
recently.  I think you need to update these patches against the latest
kernel and repost them.
