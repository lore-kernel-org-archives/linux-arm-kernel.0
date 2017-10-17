From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 17 Oct 2017 23:46:17 +0200
Subject: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
In-Reply-To: <20170911201145.31257-2-fcooper@ti.com>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
Message-ID: <20171017214617.a7ewlkhbpgze76bq@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 11, 2017 at 03:11:44PM -0500, Franklin S Cooper Jr wrote:
> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
> unlike other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
> is required to insure the power domain used by the specific I2C instance is
> properly turned on along with its functional clock.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/c9ebd1f3/attachment.sig>
