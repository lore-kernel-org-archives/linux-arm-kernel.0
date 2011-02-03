From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Feb 2011 11:08:37 +0000
Subject: barriers in mutexes?
In-Reply-To: <4D4A0D7A.9090005@codeaurora.org>
References: <4D4A0D7A.9090005@codeaurora.org>
Message-ID: <20110203110837.GA14627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 06:05:46PM -0800, Steve Muckle wrote:
> Hello,
> 
> Looking at kernel/mutex.c and arch/arm/include/asm/mutex.h, it appears
> there aren't any memory barriers in the fast path of mutexes. I see this
> was discussed here a long time back:
> 
> http://patchwork.kernel.org/patch/25856/
> 
> How was this resolved?

bac4e96 ([ARM] barriers: improve xchg, bitops and atomic SMP barriers)
