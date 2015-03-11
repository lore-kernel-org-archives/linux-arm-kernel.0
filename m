From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 Mar 2015 14:31:06 -0700
Subject: [PATCH 1/2] ARM: rockchip: decrease the wait time for resume
In-Reply-To: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
References: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=VAnqGDin26nnVHa+hsida5zgZKpQR-VNYj-9z0HhO=SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 9, 2015 at 5:12 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> The delay time for wait the 24MHz OSC stabilization is 750ms, and the
> delay time for wait the external PMU stabilization is 750ms too, let's
> decrease them to 30ms.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>
>  arch/arm/mach-rockchip/pm.c | 3 +++
>  arch/arm/mach-rockchip/pm.h | 4 ++++
>  2 files changed, 7 insertions(+)

I have done a lot of testing and as far as I'm aware this patch is
safe and right.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
