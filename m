From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Oct 2009 19:51:26 +0100
Subject: msm_sdcc.c: add missing include
In-Reply-To: <20091022072119.GA3285@elf.ucw.cz>
References: <20091022072119.GA3285@elf.ucw.cz>
Message-ID: <20091022185126.GA4401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 09:21:19AM +0200, Pavel Machek wrote:
> 
> Add missing include for	msm_sdcc compilation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I don't think this is the right solution - why should MSM have a
platform specific include in the ARM generic include files?

(If anything, we should be getting rid of any non-shared platform
specific includes in the arch/arm/include/asm/mach directory.)
