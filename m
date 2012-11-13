From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 16:41:51 +0900
Subject: [PATCH 2/2] regulator: gpio-regulator: fix can't find regulator
 node in dt
In-Reply-To: <1352714392-30497-1-git-send-email-Frank.Li@freescale.com>
References: <1352714392-30497-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20121113074146.GK18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 05:59:52PM +0800, Frank Li wrote:
> Need initilize of_node in regulator config when register regulator,
> otherwise regulator driver think it is no-dt device.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/f304e241/attachment.sig>
