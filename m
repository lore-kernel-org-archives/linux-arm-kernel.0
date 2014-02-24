From: kim.phillips@freescale.com (Kim Phillips)
Date: Mon, 24 Feb 2014 11:22:00 -0600
Subject: [PATCH] ARM: boot: compressed: ignore bswapsdi2.S
In-Reply-To: <alpine.LFD.2.11.1402201530022.17677@knanqh.ubzr>
References: <1392899163-25846-1-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.11.1402201530022.17677@knanqh.ubzr>
Message-ID: <20140224112200.6d917e21d2f6502b6076aa9b@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Feb 2014 15:30:31 -0500
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> On Thu, 20 Feb 2014, Mark Rutland wrote:
> 
> > Commit 017f161a55b4 (ARM: 7877/1: use built-in byte swap function) added
> > bswapsdi2.{o,S}  to arch/arm/boot/compress/Makefile, but didn't update
> > the .gitignore. Thus after a build git status shows bswapsdi2.S as a new
> > file, which is a little annoying.
> > 
> > This patch updates arch/arm/boot/compress/.gitignore to ignore
> > bswapsdi2.S, as we already do for ashldi3.S and others.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kim Phillips <kim.phillips@freescale.com>
> > Cc: Nicolas Pitre <nico@linaro.org>
> > Cc: David Woodhouse <David.Woodhouse@intel.com>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Kim Phillips <kim.phillips@freescale.com>

Thanks,

Kim
