From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 16 Sep 2009 11:45:56 +0100
Subject: [PATCH] S3C64XX I2S: S3C64XX_PA_IISV4 defined
In-Reply-To: <1253076469-20172-1-git-send-email-jassi.brar@samsung.com>
References: <1253076469-20172-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916104555.GA9130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 01:47:49PM +0900, Jassi wrote:

>  #define S3C64XX_PA_IIS1		(0x7F003000)
> +#define S3C64XX_PA_IISV4	(0x7F00D000)
>  #define S3C64XX_PA_TIMER	(0x7F006000)

This is already in -next, commit 25b15da14a789846672e73d19862b5fe5ad14346.
