From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 4 Feb 2012 17:50:03 +0000
Subject: [PATCH] Versatile Express: add NO_IOPORT
In-Reply-To: <20120204105013.GR889@n2100.arm.linux.org.uk>
References: <20120204105013.GR889@n2100.arm.linux.org.uk>
Message-ID: <20120204175003.GA30910@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2012 at 10:50:13AM +0000, Russell King - ARM Linux wrote:
> On Versatile Express, the PCI Express buses are broken and unusable, so
> we aren't going to support PCI/ISA IO cycles on this platform.  Remove
> the PCI/ISA IO inb et.al. support for this platform.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
