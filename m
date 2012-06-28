From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Jun 2012 12:46:16 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <201206281121.56769.arnd@arndb.de>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <1340853214-5429-2-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de>
Message-ID: <20120628114616.GE28922@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 11:21:56AM +0000, Arnd Bergmann wrote:

> What platform is this driver for?
>  - If it's for an existing platform that does not have DT support, please
>    include the platform changes for that platform so we can see what gets
>    done in there.

This is really not normal practice for device drivers, it'd be a serious
obstacle to getting drivers integrated if we have to have a board merged
with every driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120628/85bd8638/attachment.sig>
