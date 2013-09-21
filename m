From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Sep 2013 14:36:46 +0100
Subject: [PATCH v2 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20130921120036.5730dbfd@armhf>
References: <20130921120036.5730dbfd@armhf>
Message-ID: <20130921133646.GV21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 12:00:36PM +0200, Jean-Francois Moine wrote:
> At probe time, when the clock driver is not yet initialized, the
> external clock of the kirkwood sound device will not be usable.
> 
> This patch fixes this problem defering the device probe.

Applied, thanks.  It won't do anything without a version of patch 1 but
there's no build time dependency and it seems like we should get a fix
into the core for the unspecified vs unregistered problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130921/a2041cbe/attachment.sig>
