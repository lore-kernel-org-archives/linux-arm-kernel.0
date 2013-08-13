From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 13:44:40 +0100
Subject: [PATCH V4 0/4] Add i2s support on smdk5420
In-Reply-To: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130813124440.GX6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 03:19:50PM +0530, Padmavathi Venna wrote:
> Samsung has different versions of I2S introduced in different
> platforms. Each version has some new support added for multichannel,
> secondary fifo, s/w reset control, internal mux for rclk src clk and
> tdm support. Each newly added change has a quirk. So this patch adds
> all the required quirks as driver data and based on compatible string
> from dtsi fetches the quirks. This also adds i2s support on exynos5420.

Applied all these, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/2b18da26/attachment.sig>
