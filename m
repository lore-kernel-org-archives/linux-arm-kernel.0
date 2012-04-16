From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 16 Apr 2012 19:51:53 +0100
Subject: [PATCH v4 2/2] regulator: add device tree support for max8997
In-Reply-To: <1332582590-16382-3-git-send-email-thomas.abraham@linaro.org>
References: <1332582590-16382-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120416185153.GH3219@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2012 at 03:19:50PM +0530, Thomas Abraham wrote:
> Add device tree based discovery support for max8997.

I tried to apply this but it's collided with some other changes in the
driver which have arrived in the meantime and the rejects were too large
to fix up.  I suspect it's mostly just the change in parameters for
regulator_register().  Can you please regenerate against my current
topic/drivers branch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120416/d0eff970/attachment.sig>
