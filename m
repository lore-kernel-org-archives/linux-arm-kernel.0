From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Sep 2013 15:47:43 +0100
Subject: [PATCH] clk: wm831x: get rid of the implementation of remove
 function
In-Reply-To: <1380203295-11030-1-git-send-email-ldewangan@nvidia.com>
References: <1380203295-11030-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20130926144743.GQ19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 07:18:15PM +0530, Laxman Dewangan wrote:
> The remove function implemented for platform driver's remove callback
> just return 0 as part of its implementation.
> 
> Remove this APIs and do not pass the valid .remove for platform driver.

Yes, this should have been done when the driver was coverted to
devm_clk_register()

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/e74e0792/attachment.sig>
