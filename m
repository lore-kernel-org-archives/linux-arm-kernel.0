From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Mar 2016 16:52:54 +0100
Subject: [v6, 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <1457518131-11339-5-git-send-email-yangbo.lu@nxp.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-5-git-send-email-yangbo.lu@nxp.com>
Message-ID: <20160312155254.GJ1661@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:08:50PM +0800, Yangbo Lu wrote:
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as
> a common header file. It has been used for mpc85xx and it will
> be used for ARM-based SoC as well.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

>From a glimpse, looks like proper refactoring. Thanks!

For the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160312/d8b2c662/attachment.sig>
