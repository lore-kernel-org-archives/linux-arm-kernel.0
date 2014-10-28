From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 16:52:54 +0100
Subject: [PATCH v3 2/6] pinctrl: rockchip: save and restore gpio6_c6
 pinmux in suspend/resume
In-Reply-To: <1413863011-2736-1-git-send-email-zyw@rock-chips.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
 <1413863011-2736-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CACRpkda6ebV51bPeyn6qsR97CdeV6nSTTsJmHmrcj-C0OXyDEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 5:43 AM,  <zyw@rock-chips.com> wrote:

> From: Chris Zhong <zyw@rock-chips.com>
>
> Save and restore the gpio6_c6 pinmux setting, since Maskrom of RK3288
> would modify it to sdmmc0_det, so it need to be restored to the correct
> setting after resume from Maskrom.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2: None

Heiko, ping on this too.

Yours,
Linus Walleij
