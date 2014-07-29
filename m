From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 09:15:29 -0700
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <1405704009-8430-2-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-2-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=Xnb12GM-miAbA-6fmAbBCRiW2ejs=Veep+TQakv3MgZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
> Spring does not need it, it uses an s5m8767 instead.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi | 151 -------------------------
>  arch/arm/boot/dts/exynos5250-snow.dts         | 155 ++++++++++++++++++++++++++
>  2 files changed, 155 insertions(+), 151 deletions(-)

Personally I would have squashed patches 1-3, but I don't have a
problem with it being broken up and it does mean that the mondo patch
is smaller, so...

Reviewed-by: Doug Anderson <dianders@chromium.org>

Kukjin could apply this now if he wanted to avoid future conflicts.

-Doug
