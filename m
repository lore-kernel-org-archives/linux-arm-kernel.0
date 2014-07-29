From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 09:16:11 -0700
Subject: [PATCH v2 2/4] ARM: dts: exynos5250: cypress,cyapa trackpad is
 Snow only
In-Reply-To: <1405704009-8430-3-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-3-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=VAWG=H9=mwKZfip9zvAROU3aVXihnaBUBr0GNSzDoWFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
> Spring does not need it, it uses an Atmel maXTouch instead.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |  8 --------
>  arch/arm/boot/dts/exynos5250-snow.dts         | 10 ++++++++++
>  2 files changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>

Kukjin could apply this now if he wanted to avoid future conflicts.
