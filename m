From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:51:36 +0200
Subject: [PATCH 2/5] panel-simple: Add the 7" DPI panel from Adafruit.
In-Reply-To: <1458865431-30048-3-git-send-email-eric@anholt.net>
References: <1458865431-30048-1-git-send-email-eric@anholt.net>
 <1458865431-30048-3-git-send-email-eric@anholt.net>
Message-ID: <20160415145136.GI3472@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 05:23:48PM -0700, Eric Anholt wrote:
> This is a basic TFT panel with a 40-pin FPC connector on it.  The
> specification doesn't define timings, but the Adafruit instructions
> were setting up 800x480 CVT.
> 
> v2: Add .bus_format and vsync/hsync flags.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/panel/ontat,yx700wv03.txt     |  7 +++++
>  drivers/gpu/drm/panel/panel-simple.c               | 35 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/e570ea0d/attachment.sig>
