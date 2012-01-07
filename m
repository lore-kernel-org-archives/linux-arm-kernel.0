From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 7 Jan 2012 00:53:50 +0000
Subject: [PATCH v8 2/2] davinci: CQ93VC: remove machine specific header
 file inclusion from codec driver
In-Reply-To: <1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
References: <1325661469-4411-1-git-send-email-manjunath.hadli@ti.com>
 <1325661469-4411-3-git-send-email-manjunath.hadli@ti.com>
Message-ID: <20120107005350.GA26307@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 12:47:49PM +0530, Manjunath Hadli wrote:
> remove unnecessary inclusion of machine specific header
> file mach/dm365.h from cq93vc.c voice codec driver
> which comes in the way of platform code consolidation.

*Always* CC maintainers on patches.  If you send me a copy directly this
looks OK.
