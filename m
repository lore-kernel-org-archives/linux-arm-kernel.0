From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 14 Jan 2012 21:07:36 +0200
Subject: [PATCH 00/11] ep93xx: Move SoC private bits to core
In-Reply-To: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
Message-ID: <20120114190736.GA20641@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 02:14:25PM +1100, Ryan Mallon wrote:
> This patch series is an effort to move the ep93xx SoC specific code out
> of drivers and include/mach into arch/arm/mach-ep93xx. This work
> involves the following changes:
> 
>  - Create a new private header called soc.h to replace most of 
>    mach/include/ep93xx-regs.h
>  - Move the Maverick crunch code from arch/arm/kernel to mach-ep93xx
>  - Move all system controller access to the ep93xx core code
> 
> There are a small handful of defines left in ep93xx-regs.h which are
> used by both the ep93xx core and include/mach files (uncompress.h,
> debug-macro.S, etc).

Sorry for the delay. I went through the series and it looks good to me. You
can add

Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>

for all the patches, if you like.

Thanks!
