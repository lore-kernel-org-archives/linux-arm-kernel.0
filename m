From: broonie@kernel.org (Mark Brown)
Date: Sat, 31 Aug 2013 18:28:53 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <52220B9A.9000007@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
Message-ID: <20130831172853.GL18608@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:

> Then connect the SPDIF AIF widgets to the SPDIF streams and the I2S AIF
> widgets to the I2S streams. In your machine driver setup the link config to
> use DAI 0 if the board uses I2S and DAI 1 if the board uses SPDIF. The ASoC
> framework will then create the necessary routes all by itself. Of course
> this won't work on a platform where both the SPDIF and I2S controller are
> used at the same time, but neither does your current solution.

This is the either/or approach I've been suggesting.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130831/f644636a/attachment-0001.sig>
