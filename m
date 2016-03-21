From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Mar 2016 07:48:10 -0500
Subject: [PATCH 2/5] panel-simple: Add the 7" DPI panel from Adafruit.
In-Reply-To: <1458355366-7073-3-git-send-email-eric@anholt.net>
References: <1458355366-7073-1-git-send-email-eric@anholt.net>
 <1458355366-7073-3-git-send-email-eric@anholt.net>
Message-ID: <20160321124810.GA15878@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 07:42:43PM -0700, Eric Anholt wrote:
> This is a basic TFT panel with a 40-pin FPC connector on it.  The
> specification doesn't define timings, but the Adafruit instructions
> were setting up 800x480 CVT.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/panel/ontat,yx700wv03.txt     |  7 +++++
>  drivers/gpu/drm/panel/panel-simple.c               | 33 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ontat,yx700wv03.txt

Acked-by: Rob Herring <robh@kernel.org>
