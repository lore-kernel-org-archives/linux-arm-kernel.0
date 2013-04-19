From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 19 Apr 2013 20:35:08 +0200
Subject: [PATCH] I2C: EXYNOS: High speed mode clock setting for HSI2C
In-Reply-To: <1366372583-7584-1-git-send-email-yuvaraj.cd@samsung.com>
References: <1366372583-7584-1-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20130419183508.GC3702@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 05:26:23PM +0530, Yuvaraj Kumar C D wrote:
> This patch configure the High speed mode timing register using the
> clock speed mentioned in the dts file.Also it configure the MASTER_ID
> for High speed i2c transfer.
> For i2c high speed transaction, tarnsaction initially starts with the
> fast mode i,e 400Kbits/sec and then switches to high speed mode.For this
> purpose it requires to set up timing value for fast mode and high speed
> mode.
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Since the exynos5 driver needs to be resent anyhow, I assume this will
be included in the next version? Please note that I had comments
regarding the bindings of the bus speed. We have a generic binding for
that already.

Thanks,

   Wolfram
