From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jun 2013 11:35:57 +0100
Subject: [PATCH] spi: pl022: remove unused ret and pins_state variables
In-Reply-To: <1371463695-21252-1-git-send-email-fabio.baltieri@linaro.org>
References: <1371463695-21252-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130617103557.GC1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 12:08:15PM +0200, Fabio Baltieri wrote:
> Removes the warnings:
> 
> drivers/spi/spi-pl022.c: In function 'pl022_suspend_resources':
> drivers/spi/spi-pl022.c:2322:24: warning: unused variable 'pins_state' [-Wunused-variable]
> drivers/spi/spi-pl022.c:2321:6: warning: unused variable 'ret' [-Wunused-variable]
> drivers/spi/spi-pl022.c: In function 'pl022_resume_resources':
> drivers/spi/spi-pl022.c:2334:6: warning: unused variable 'ret' [-Wunused-variable]
> 
> introduced in:
> 
> f1c9cf0 spi: pl022: use pinctrl PM helpers

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/78f4d9e4/attachment.sig>
