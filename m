From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Jul 2018 00:25:37 +0200
Subject: [PATCH] i2c: aspeed: Fix initial values of master and slave state
In-Reply-To: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180720222537.2ldpgsign52dutkn@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 02:20:28PM -0700, Jae Hyun Yoo wrote:
> This patch changes the order of enum aspeed_i2c_master_state and
> enum aspeed_i2c_slave_state defines to make their initial value to
> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
> In case of multi-master use, if a slave data comes ahead of the
> first master xfer, master_state starts from an invalid state so
> this change fixes the issue.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/1eae0a0c/attachment.sig>
