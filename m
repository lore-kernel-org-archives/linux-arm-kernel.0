From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 14:22:01 +0200
Subject: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
In-Reply-To: <20180907041948.19913-5-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
 <20180907041948.19913-5-wens@csie.org>
Message-ID: <20180927122201.GH29102@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2018 at 12:19:46PM +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
> 
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
> 
> Depending on the variant, the PCB attached to the panel module either
> supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> itself.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt

Next time, please make the bindings and driver changes separate patches.

Applied, thanks.
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180927/27bd0611/attachment.sig>
