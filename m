From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Jun 2012 13:17:43 +0100
Subject: [PATCH v2 0/5] mmp audio support
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120613121743.GN4545@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 06:04:36PM +0800, Zhangfei Gao wrote:

> These patches provide mmp audio support under alsa via dmaengine
> Support platfrom pxa688 and pxa910
> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
> pxa688 (mmp2) use mmp2-sspa.c
> pxa910 directly use pxa-ssp.c
> mmp_tdma.c is under dmaengine framework

Applied 2-4.  I'm not seeing a direct code dependency between this and
the dmaengine driver in patch 1 (or review of it from Vinod yet) so I'm
expecting that to go via the dmaengine tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120613/17cbd502/attachment.sig>
