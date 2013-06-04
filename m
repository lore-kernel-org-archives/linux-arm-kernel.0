From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Jun 2013 18:44:10 +0100
Subject: [PATCH] ASoC: omap-hdmi-codec: make the driver common for other
 SoCs
In-Reply-To: <1368684487-8890-1-git-send-email-Baohua.Song@csr.com>
References: <1368684487-8890-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130604174410.GR31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:08:07PM +0800, Barry Song wrote:
> to support HDMI on CSR SiRFprimaII and atlasVI, we need one more HDMI pseudo
> codec, rather than add a new driver, we can make omap HDMI codec common for
> other SoCs as well. then the omap-hdmi codec becomes a generic HDMI pseudo-
> codec as HDMI audio features depend on HDMI specification not on SoCs.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/5425f4b0/attachment.sig>
