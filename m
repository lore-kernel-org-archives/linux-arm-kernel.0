From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 12:02:02 +0100
Subject: [PATCH 09/14] ASoC: kirkwood-dma: remove IEC958_SUBFRAME formats
In-Reply-To: <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
Message-ID: <20130902110202.GO3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 01:43:36PM +0100, Russell King wrote:
> The Audio block does not support IEC958 subframes as formatted by
> ALSA: they're very close, but not close enough.  The formats differ

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/e9924e23/attachment.sig>
