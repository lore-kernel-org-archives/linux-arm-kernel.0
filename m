From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 00:56:07 +0100
Subject: [PATCH 24/24] net: seeq: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-25-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-25-git-send-email-arnd@arndb.de>
Message-ID: <20120914235607.GF12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34:52PM +0200, Arnd Bergmann wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.

Same comment as for eesox.  const void __iomem * is not a problem on
x86, so it should not be a problem on ARM.
