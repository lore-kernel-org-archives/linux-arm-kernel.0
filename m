From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 11:11:40 +0100
Subject: [PATCH 3/4] ASoC: mxs: register saif mclk to clock framework
In-Reply-To: <1372666571-17276-4-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130701101140.GC27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 04:16:10PM +0800, Shawn Guo wrote:
> Mostly the mxs system design uses saif0 mclk output as the clock source
> of codec.  Since the mclk is implemented as a general divider with the
> saif clk as the parent clock, let's register the mclk as a basic
> clk-divider to common clock framework.  Then with it being a clock
> provdier, clk_get() call in codec driver probe function will just work.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/353cc584/attachment.sig>
