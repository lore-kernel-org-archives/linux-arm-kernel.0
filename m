From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Jun 2012 17:33:36 +0200
Subject: [PATCHv8 00/13] I2C cleanups
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120618153336.GD10768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 08:00:15PM +0530, Shubhrajyoti D wrote:
> 
> The patch series does the following
> 
> - I2C register restore only if context if the context is lost
> - Bus busy recovery mechanism.
> - the reset is not done in init.
> - Adds a patch to use devm_* functions
> - Adds a pdata function pointer to do context save restore
> - Split the omap_i2c_isr to increase readability
> - Make the i2c use SET_RUNTIME_PM_OPS
> - Use INIT_COMPLETION instead of init_completion
> - Dropping a cleanup and taking few patchs Felipe's series as it may
>  not be needed.

Patches look mostly okay for me without knowing the platform too much.
For that reason, I'd be really appreciating Tested-by or even
Reviewed-by tags!

> This series mainly is the cleanups rebased on
> i2c-embedded/for-next branch.

Thanks.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/cb82cb11/attachment.sig>
