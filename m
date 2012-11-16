From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 16 Nov 2012 15:20:06 +0100
Subject: [PATCHv3] i2c: omap: Move the remove constraint
In-Reply-To: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
References: <1352969361-10521-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121116142006.GG7313@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 02:19:21PM +0530, Shubhrajyoti D wrote:
> Currently we just queue the transfer and release the
> qos constraints, however we do not wait for the transfer
> to complete to release the constraint. Move the remove
> constraint after the bus busy as we are sure that the
> transfers are completed by then.
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Applied to for-next. Please let me know if it should go to for-current.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/3ac6caa5/attachment.sig>
