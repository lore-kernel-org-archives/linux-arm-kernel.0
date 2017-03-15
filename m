From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 19:02:12 +0000
Subject: [PATCH 1/3] ASoC : Add an IC bit and frame master mode (SoC and
 Codec slave).
In-Reply-To: <057bbc69c3dcbb5199782ae6fe44d73862b8a1d1.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <057bbc69c3dcbb5199782ae6fe44d73862b8a1d1.1487997974.git.flatmax@flatmax.org>
Message-ID: <20170315190212.x5c3kyyl4osrs4gu@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 04:03:12PM +1100, Matt Flax wrote:
> This patch adds a new clock mode to the SoC system. The new mode
> allows for an IC (between the SoC and the Codec) to be bit and
> frame master.
> 
> As SoC and codec drivers default to return -EINVAL, this new mode
> can not set either as master.

I think I'd expect to see this device represented as a CODEC with two
CODEC-CODEC links rather than transparently as here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/8c2864b7/attachment.sig>
