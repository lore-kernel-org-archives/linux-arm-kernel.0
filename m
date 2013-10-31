From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Oct 2013 11:36:44 -0700
Subject: [PATCH v4 3/4] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
References: <cover.1383226444.git.b42378@freescale.com>
 <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
Message-ID: <20131031183644.GJ2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 09:44:15PM +0800, Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.
> 
> [ Passed compile-test with mpc85xx_defconfig ]

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/09322872/attachment.sig>
