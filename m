From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 May 2013 12:29:11 +0100
Subject: [PATCH] clk: use platform_{get,set}_drvdata()
In-Reply-To: <000401ce581b$a9224600$fb66d200$@samsung.com>
References: <000401ce581b$a9224600$fb66d200$@samsung.com>
Message-ID: <20130527112910.GD21462@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 10:11:46AM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130527/1c991f42/attachment-0001.sig>
