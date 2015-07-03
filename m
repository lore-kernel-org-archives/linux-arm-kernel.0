From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 3 Jul 2015 16:55:28 +0900
Subject: [PATCH v2 4/5] drm/rockchip: vop: switch cursor plane to window 3
In-Reply-To: <1435313249-4549-5-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-5-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAAFQd5C+iJtTYpSkb14dzy4qbM0BEBu1zj2sr-KH+FG7gWDvZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 7:07 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> Window 1 support scale and yuv format, it's waste use it for a
> cursor, use window 3 is enough.
>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v2: None
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
