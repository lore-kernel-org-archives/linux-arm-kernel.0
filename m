From: dianders@chromium.org (Doug Anderson)
Date: Fri, 17 May 2013 12:17:02 -0700
Subject: [PATCH 1/6] pinctrl: exynos: Add support for set_irq_wake of
 wake-up EINTs
In-Reply-To: <1368807872-2601-2-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-2-git-send-email-t.figa@samsung.com>
Message-ID: <CAD=FV=V-GfvVi++6Mrz2d=idRkj3q5O0NQQmCGE=0vi1=sD5cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Fri, May 17, 2013 at 9:24 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> This patch adds support of IRQ wake-up ability configuration for
> wake-up EINTs on Exynos SoCs.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/pinctrl/pinctrl-exynos.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

On exynos5250-snow (pinmux backported to 3.8):

Tested-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Doug Anderson <dianders@chromium.org>
