From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jan 2012 18:47:41 +0000
Subject: [RESEND PATCH] davinci: CQ93VC: remove machine specific header
 file inclusion from codec driver
In-Reply-To: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
References: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <20120110184741.GG7164@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 04:57:43PM +0530, Manjunath Hadli wrote:
> remove unnecessary inclusion of machine specific header
> file mach/dm365.h from cq93vc.c voice codec driver
> which comes in the way of platform code consolidation.

Applied but please do try to use a subject line appropriate for the
subsystem you're contributing to.
