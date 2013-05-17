From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 May 2013 12:24:41 -0700
Subject: [PATCH 5/6] pinctrl: samsung: Allow per-bank SoC-specific private
 data
In-Reply-To: <1368807872-2601-6-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-6-git-send-email-t.figa@samsung.com>
Message-ID: <CAD=FV=VPoBEQ6fGscPYBnVyThKbMdOgXznrMoA97HHaTp0coGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Fri, May 17, 2013 at 9:24 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch extends pin bank descriptor structure with SoC-specific
> private data field that allows SoC-specific drivers to store their own
> private data.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/pinctrl/pinctrl-samsung.h | 1 +
>  1 file changed, 1 insertion(+)

Sure.  Seems like it could be squashed into the next patch, but I
think it looks fine separate too.

On exynos5250-snow (pinmux backported to 3.8):

Tested-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Doug Anderson <dianders@chromium.org>
