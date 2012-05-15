From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 May 2012 18:37:09 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Hook up carrier class modules on
 Cragganmore
In-Reply-To: <07fc01cd3278$dbbf63f0$933e2bd0$%kim@samsung.com>
References: <1337016041-16096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1337016041-16096-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <07fc01cd3278$dbbf63f0$933e2bd0$%kim@samsung.com>
Message-ID: <20120515173706.GD4140@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 05:58:12PM +0900, Kukjin Kim wrote:

> Looks good to me, but there is no '{ I2C_BOARD_INFO("wlf-gf-module", 0x20) },' in my tree.

> Just adding address 0x22 stuff is enough now?

Yes, it is - sorry, context diff for another project.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120515/56b88648/attachment-0001.sig>
