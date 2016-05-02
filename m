From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 May 2016 11:42:13 +0100
Subject: [PATCH v3 6/7] ASoC: omap-mcbsp: sidetone: Use the new callback
 for iclk handling
In-Reply-To: <1461927202-17677-7-git-send-email-peter.ujfalusi@ti.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <1461927202-17677-7-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160502104213.GD6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 01:53:21PM +0300, Peter Ujfalusi wrote:
> The McBSP sidetone (in OMAP3 McBSP2 and 3 module) is working with the
> module's interface clock. When the sidetone is enabled the iclk must not
> idle because it will result in choppy sidetone.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/4fc40c4e/attachment.sig>
