From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 17:01:35 +0200
Subject: [PATCH v3 11/19] drm/panel: simple: Add timings for the Olimex
 LCD-OLinuXino-4.3TS
In-Reply-To: <1458751122-23976-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-12-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415150135.GA1088@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:38:34PM +0100, Maxime Ripard wrote:
> Add support for the Olimex LCD-OLinuXino-4.3TS panel to the DRM simple
> panel driver.
> 
> It is a 480x272 panel connected through a 24-bits RGB interface.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/panel/olimex,lcd-olinuxino-43-ts.txt   |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/85336cbb/attachment.sig>
