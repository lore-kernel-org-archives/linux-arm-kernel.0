From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 21:54:46 -0700
Subject: [PATCH v6 04/10] ARM: dts: Clean up exynos5250-snow
In-Reply-To: <1406940750-15880-5-git-send-email-afaerber@suse.de>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-5-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=WB_JP_jAp5bC-cBtJs8U0AmrxPGj_J2d6uJkn=LEjEPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Aug 1, 2014 at 5:52 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Use the new style of referencing inherited nodes and use symbolic names.
> Reorder one pinctrl node in GPIO order.
>
> Goal is the alignment of all exynos5250 based device trees for comparison.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v5 -> v6:
>  * Split off label additions (Doug Anderson)
>  * Fixed alphabetical order of sd3_* nodes (Doug Anderson)
>
>  v4 -> v5:
>  * Introduced labels to consistently use new referencing style (Tomasz Figa)
>  * Use IRQ_TYPE_* constants
>  * Use some more GPIO_ACTIVE_*
>
>  v3 -> v4: Unchanged
>
>  v3: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-snow.dts | 291 +++++++++++++++++-----------------
>  1 file changed, 145 insertions(+), 146 deletions(-)

I'm happy now.  :)  Thank you for putting up with me...

Reviewed-by: Doug Anderson <dianders@chromium.org>
