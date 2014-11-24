From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Nov 2014 10:38:27 +0100
Subject: [PATCH v6]  i2c: s3c2410: Handle i2c sys_cfg register in i2c
 driver
In-Reply-To: <1416818018-6684-1-git-send-email-pankaj.dubey@samsung.com>
References: <1416818018-6684-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20141124093827.GC3733@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 02:03:38PM +0530, Pankaj Dubey wrote:
> Let's handle i2c interrupt re-configuration in i2c driver. This will
> help us in removing some soc specific checks from machine files and
> will help in removing static iomapping of SYS register in exynos.c
> 
> Also handle saving and restoring of SYS_I2C_CFG register during
> suspend and resume of i2c driver.
> 
> CC: Wolfram Sang <wsa@the-dreams.de>
> CC: linux-i2c at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/0ce3b25a/attachment-0001.sig>
