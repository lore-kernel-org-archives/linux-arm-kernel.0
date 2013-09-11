From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 16:44:33 +0100
Subject: [PATCH v2 7/9] ASoC: codecs: convert existing I2C client drivers
 to use I2C core runtime PM
In-Reply-To: <1378913560-2752-8-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-8-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130911154433.GV29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:32:38PM +0300, Mika Westerberg wrote:
> The I2C core now prepares runtime PM on behalf of the I2C client device, so
> only thing the driver needs to do is to call pm_runtime_put() at the end of
> its ->probe().
> 
> This patch converts ASoC codec drivers to use this model.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/576dd7ce/attachment-0001.sig>
