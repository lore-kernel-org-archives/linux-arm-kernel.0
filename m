From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:38:36 +0000
Subject: [PATCH 07/11] ASoC: ux500_pcm: Extend Device Tree support to
 deal with DMA data
In-Reply-To: <1387468508-12286-8-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153836.GP31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:04PM +0000, Lee Jones wrote:
> Soon we will strip out pdata support from the Ux500 set of ASoC drivers.
> When this happens it will have to supply a DMA slave_config to the
> dmaengine. At the moment a great deal of this comes from pdata via
> AUXDATA. We need to become independent of this soon. This patch starts
> the process by allocating memory for the associated data structures and
> fetches the MSP id used for const struct indexing.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/a203d2af/attachment.sig>
