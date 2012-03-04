From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:26:27 +0000
Subject: [PATCH 08/20] ASoC: imx: initialize dma_params burstsize just in
 imx-ssi
In-Reply-To: <1330788001-10158-9-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-9-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304132627.GA3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:19:49PM +0800, Shawn Guo wrote:
> It's not necessary for imx-pcm-dma-mx2 to access imx_ssi.dma_params
> for burstsize initialization.  Instead, it can just be done in imx-ssi
> probe function once.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/b1fa08ce/attachment-0001.sig>
