From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Oct 2014 22:01:46 -0700
Subject: [PATCH v4 4/6] ARM: rockchip: add suspend and resume for RK3288
In-Reply-To: <1413933928-25803-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933928-25803-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=VBOqkMn+wSoYdFgdTu=0Hq38xk7_fo8Vr_ACupLVBkVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:25 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> @@ -34,7 +40,8 @@ static const char * const rockchip_board_dt_compat[] = {
>  };
>
>  DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
> -       .l2c_aux_val    = 0,
> -       .l2c_aux_mask   = ~0,
> +       .l2c_aux_val    = 0,
> +       .l2c_aux_mask   = ~0,

Please avoid unrelated spacing changes.


Other than that this is looking like a good starting point.  I'm sure
we'll find other things to do, but I'd be in favor of landing this and
spinning.  I can see a device suspend/resume with this patch, so:

Tested-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
