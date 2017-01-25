From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 25 Jan 2017 21:50:44 +0100
Subject: [PATCH] i2c: mv64xxx: add suspend/resume support
In-Reply-To: <1482422042-30201-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482422042-30201-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170125205043.ze3m3wrjovajbps4@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 04:54:02PM +0100, Thomas Petazzoni wrote:
> From: Grzegorz Jaszczyk <jaz@semihalf.com>
> 
> This commit implements suspend/resume support in the mv64xxx I2C
> controller driver. There is no need to implement a ->suspend() hook, as
> calling mv64xxx_i2c_hw_init() at ->resume() time is enough.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>
> [Thomas: switch to dev_pm_ops, fix build warning when !PM.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/b5c65e38/attachment.sig>
