From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 21:16:31 -0400
Subject: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
In-Reply-To: <20120919210543.28074.10214.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
Message-ID: <20120920011630.GB17666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 02:05:43PM -0700, Tony Lindgren wrote:
> This is only used by omap1.
> 
> And to fix things properly, this should not be included
> from the drivers at all.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

or I can apply it if that's easier.
