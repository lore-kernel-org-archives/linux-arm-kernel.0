From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 4 Aug 2018 23:13:52 +0200
Subject: [PATCH i2c-next v2] i2c: aspeed: Add an explicit type casting
 for *get_clk_reg_val
In-Reply-To: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
References: <20180724203615.5770-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180804211352.h7ctrfw7qzmmxfzu@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 01:36:15PM -0700, Jae Hyun Yoo wrote:
> This commit fixes this sparse warning:
> drivers/i2c/busses/i2c-aspeed.c:875:38: warning: incorrect type in assignment (different modifiers)
> drivers/i2c/busses/i2c-aspeed.c:875:38:    expected unsigned int ( *get_clk_reg_val )( ... )
> drivers/i2c/busses/i2c-aspeed.c:875:38:    got void const *const data
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Added the 'Reported-tag' and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180804/01f720dc/attachment.sig>
