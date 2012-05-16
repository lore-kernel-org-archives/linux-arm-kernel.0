From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 May 2012 15:21:52 +0900
Subject: [PATCH 2/2] ARM: S3C64XX: Hook up carrier class modules on
 Cragganmore
In-Reply-To: <20120515173706.GD4140@opensource.wolfsonmicro.com>
References: <1337016041-16096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1337016041-16096-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <07fc01cd3278$dbbf63f0$933e2bd0$%kim@samsung.com>
 <20120515173706.GD4140@opensource.wolfsonmicro.com>
Message-ID: <093301cd332c$2ed6d060$8c847120$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, May 15, 2012 at 05:58:12PM +0900, Kukjin Kim wrote:
> 
> > Looks good to me, but there is no '{ I2C_BOARD_INFO("wlf-gf-module",
> 0x20) },' in my tree.
> 
> > Just adding address 0x22 stuff is enough now?
> 
> Yes, it is - sorry, context diff for another project.

OK, no problem.

Applied and thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
