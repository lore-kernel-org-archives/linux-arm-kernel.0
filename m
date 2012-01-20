From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2012 12:08:56 +0000
Subject: Making allyesconfig work
In-Reply-To: <20120120115108.GJ1068@n2100.arm.linux.org.uk>
References: <20120120115108.GJ1068@n2100.arm.linux.org.uk>
Message-ID: <20120120120856.GC30612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 11:51:08AM +0000, Russell King - ARM Linux wrote:
> There's also the troublesome T() macro, which conflicts with a bunch
> of other drivers.  (I've added Catalin to the To: line for this
> reason.)

This macro is used in asm/uaccess.h and asm/futex.h, so I think it would
be difficult to hide it completely. But I'm happy to rename it to
something else (IIRC, T stands for "Translated").

-- 
Catalin
