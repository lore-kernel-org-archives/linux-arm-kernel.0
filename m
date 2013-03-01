From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Mar 2013 18:23:22 +0800
Subject: [PATCH 09/12] ASoC: dmaengine_pcm: support use of generic DMA
 helper
In-Reply-To: <201302272102.40811.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-10-git-send-email-shawn.guo@linaro.org>
 <201302272102.40811.arnd@arndb.de>
Message-ID: <20130301102320.GV25302@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 09:02:40PM +0000, Arnd Bergmann wrote:

> I would actually prefer having a new API in the soc-dmaengine-pcm
> module, like

> static int dmaengine_pcm_request_slave_channel(struct dmaengine_pcm_runtime_data *prtd,
> 						struct device *dev, const char *id);

> For sound drivers that are fully converted to using DT, it would be
> a more natural interface to use IMHO.

Yes, please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130301/ddab8998/attachment.sig>
