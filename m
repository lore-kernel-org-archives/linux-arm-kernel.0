From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Oct 2011 14:10:18 -0700
Subject: [PATCH] ARM: zImage: Use $(CROSS_COMPILE)size to get .bss size
In-Reply-To: <alpine.LFD.2.02.1110121029470.17040@xanadu.home>
References: <1318419203-27165-1-git-send-email-weber@corscience.de>
	<alpine.LFD.2.02.1110121029470.17040@xanadu.home>
Message-ID: <20111012211018.GC2293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [111012 07:03]:
> On Wed, 12 Oct 2011, Thomas Weber wrote:
> 
> > Use $(CROSS_COMPILE)size to determine the bss size
> > from vmlinux.
> > 
> > The problem is introduced in:
> > commit 8738646c02064d38f6fb056eb039ebf9138c5434
> > 
> > ARM: zImage: make sure appended DTB doesn't get
> > overwritten by kernel .bss
> > 
> > This fixes following error message:
> > 
> > size: arch/arm/boot/compressed/../../../../vmlinux:
> > File format is ambiguous
> > 
> > size: Matching formats:
> > elf32-littlearm
> > elf32-littlearm-symbian
> > elf32-littlearm-vxworks
> > 
> > Signed-off-by: Thomas Weber <weber@corscience.de>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Tony Lindgren <tony@atomide.com>
