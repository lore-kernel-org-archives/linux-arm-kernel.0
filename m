From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 09:45:31 -0700
Subject: [PATCH v5 02/10] ARM: dts: Fold exynos5250-cros-common into
 exynos5250-snow
In-Reply-To: <1406868897-26874-3-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-3-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=USKuOxiFo=VgEB6aAQ=LdLv-7+jXQNh4VCMBQwasygxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> exynos5250-cros-common.dtsi was meant for sharing common pieces across
> ChromeOS devices. This turned out premature, as several devices ended up
> in the common file that are not common after all. Since the remaining
> common ChromeOS pieces are fairly minor,  exynos5250-cros-common.dtsi
> was requested to be merged into the Snow device tree, sharing only the
> keyboard controller for now. This may be re-evaluated as both mature.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4 -> v5:
>  * Extended commit message (Tomasz Figa)
>
>  v3 -> v4: Unchanged
>
>  v2 -> v3:
>  * Renamed subject to match Kukjin's style
>  * Rebased onto MMC pinctrl bug fix (Doug Anderson)
>
>  v2: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi | 164 --------------------------
>  arch/arm/boot/dts/exynos5250-snow.dts         | 164 +++++++++++++++++++++++---
>  2 files changed, 145 insertions(+), 183 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>

I'd suggest that this land sooner rather than later to avoid future conflicts.
