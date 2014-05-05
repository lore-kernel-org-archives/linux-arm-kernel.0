From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 5 May 2014 17:25:21 +0800
Subject: [PATCH v2] clk: sirf: fix a bundle of checkpatch issues
In-Reply-To: <1397555287-25544-1-git-send-email-21cnbao@gmail.com>
References: <1397555287-25544-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CAGsJ_4zMN-PoTKvbNK1UbdLbtzN_7BU9x9QzCv_PS1Oa2sPkJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-15 17:48 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> From: Bin Shi <Bin.Shi@csr.com>
>
> fix the below checkpatch issues about which users of codes - key customers care
> very much.
>
> WARNING: line over 80 characters
> 66: FILE: clk-atlas6.c:66:
> +       usp2,   vip,   gfx,   gfx2d,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
>
> total: 0 errors, 1 warnings, 153 lines checked
>
> clk-atlas6.c has style problems, please review.
>
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.
> WARNING: line over 80 characters
> 24: FILE: clk-common.c:24:
> + *     Each clock domain can select its own clock source from five clock sources,
> WARNING: line over 80 characters
> 25: FILE: clk-common.c:25:
> + *     X_XIN, X_XINW, PLL1, PLL2 and PLL3. The domain clock is used as the source
>
> WARNING: line over 80 characters
> 171: FILE: clk-common.c:171:
> +       return pll_clk_round_rate(__clk_get_hw(parent_clk), rate, &pll_parent_rate);
>
> WARNING: static const char * array should probably be static const char * const
> 191: FILE: clk-common.c:191:
> +static const char *pll_clk_parents[] = {
>
> WARNING: line over 80 characters
> 260: FILE: clk-common.c:260:
> +static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>
> WARNING: static const char * array should probably be static const char * const
> 287: FILE: clk-common.c:287:
> +static const char *dmn_clk_parents[] = {
>
> WARNING: static const char * array should probably be static const char * const
> 676: FILE: clk-common.c:676:
> +static const char *std_clk_io_parents[] = {
>
> WARNING: static const char * array should probably be static const char * const
> 952: FILE: clk-common.c:952:
> +static const char *std_clk_dsp_parents[] = {
>
> WARNING: static const char * array should probably be static const char * const
> 984: FILE: clk-common.c:984:
> +static const char *std_clk_sys_parents[] = {
>
> WARNING: static const char * array should probably be static const char * const
> 1002: FILE: clk-common.c:1002:
> +static const char *std_clk_usb_parents[] = {
>
> total: 0 errors, 10 warnings, 1032 lines checked
>
> clk-common.c has style problems, please review.
>
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.
> total: 0 errors, 0 warnings, 1032 lines checked
>
> clk-common.c.orig has no obvious style problems and is ready for submission.
> WARNING: line over 80 characters
> 65: FILE: clk-prima2.c:65:
> +       usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
>
> total: 0 errors, 1 warnings, 152 lines checked
>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

ping Mike, would you apply this as i have one more after this.

-barry
