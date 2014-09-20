From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 20 Sep 2014 04:14:10 +0200
Subject: [PATCH v11 03/10] ARM: Define PCI_IOBASE as the base of virtual
 PCI IO space.
In-Reply-To: <1411003825-21521-4-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201409200414.10675.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 September 2014, Liviu Dudau wrote:
> This is needed for calls into OF code that parses PCI ranges.
> It signals support for memory mapped PCI I/O accesses that
> are described be device trees.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
