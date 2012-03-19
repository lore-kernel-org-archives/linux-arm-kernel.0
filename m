From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Mar 2012 13:56:54 +0000
Subject: [PATCH v5 1/8] ASoC: fsl: separate SSI and DMA Kconfig options
In-Reply-To: <1331888204-27058-2-git-send-email-shawn.guo@linaro.org>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120319135654.GD3130@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 04:56:37PM +0800, Shawn Guo wrote:
> The fsl_ssi driver will possibly be shared between Freescale PowerPC
> and ARM/IMX families, so give it a separate Kconfig option.  Then
> fsl_ssi driver can possibly be selected independently from selecting
> PowerPC DMA based PCM driver.

Applied all, thanks for doing all this work!  They'll have to wait for
3.5 at this point sadly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/b4421d9d/attachment.sig>
