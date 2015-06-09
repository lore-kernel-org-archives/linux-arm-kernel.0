From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Jun 2015 11:17:49 -0700
Subject: [PATCH v6 3/3] ARM: rockchip: fix the SMP code style
In-Reply-To: <1433843400-24831-4-git-send-email-wxt@rock-chips.com>
References: <1433843400-24831-1-git-send-email-wxt@rock-chips.com>
 <1433843400-24831-4-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=V31o3Jj-26hiSHMikAbWw3x4p=NqUW-tca2xqUxmjgsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Jun 9, 2015 at 2:49 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> Use the below scripts to check:
> scripts/checkpatch.pl -f --subject arch/arm/mach-rockchip/platsmp.c
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> ---
>
> Changes in v6:
> - fix the commnet Unified format.
> Series-changes: 5
> - Add the changelog.
> Series-changes: 2
> - Use the checkpatch.pl -f --subjective to check.
>
>  arch/arm/mach-rockchip/platsmp.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

This patch hasn't changed, so you could have kept my Reviewed-by that
I gave previously.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
