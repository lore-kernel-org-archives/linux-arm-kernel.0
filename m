From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 23:54:47 +0100
Subject: [PATCH 3/3] dt-bindings: spi/rockchip: Mark DMA as optional
In-Reply-To: <1409777067-17422-4-git-send-email-dianders@chromium.org>
References: <1409777067-17422-1-git-send-email-dianders@chromium.org>
 <1409777067-17422-4-git-send-email-dianders@chromium.org>
Message-ID: <20140904225447.GZ29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 01:44:27PM -0700, Doug Anderson wrote:
> The Rockchip SPI controller works fine without DMA (aside from a few
> warnings).  The DMA property even implies this, saying:

Applied all, thanks.  Please use subject bindings matching the style for
the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/43fd0c4f/attachment.sig>
