From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 12:35:33 +0100
Subject: [PATCH 2/3] ARM:dts: vf610: Add DSPI nodes
In-Reply-To: <1373272622-29064-2-git-send-email-b44548@freescale.com>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
 <1373272622-29064-2-git-send-email-b44548@freescale.com>
Message-ID: <20130708113533.GT27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 04:37:01PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> Add Freescale DSPI node into vf610 dts.
> 
> Signed-off-by: Chao Fu <b44548@freescale.com>

Acked-by: Mark Brown <broonie@linaro.org>

This should be fine to merge via arm-soc, it's no real dependency on the
driver itself or driver specific bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/6012ee64/attachment.sig>
