From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 13:46:05 +0900
Subject: [PATCH v2 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <1392765432-9111-3-git-send-email-mporter@linaro.org>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-3-git-send-email-mporter@linaro.org>
Message-ID: <20140219044605.GB2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:17:09PM -0500, Matt Porter wrote:

> +config MFD_BCM590XX
> +	bool "Broadcom BCM590xx PMUs"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	depends on I2C=y
> +	help
> +	  Support for the BCM590xx PMUs from Broadcom
> +

Why does this need to be built in?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/0fccb03f/attachment.sig>
