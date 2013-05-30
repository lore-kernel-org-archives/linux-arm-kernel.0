From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 May 2013 09:50:53 -0700
Subject: [PATCH v2 4/5] clk: samsung: Add set_rate() clk_ops for PLL36xx
In-Reply-To: <1369834677-20312-5-git-send-email-vikas.sajjan@linaro.org>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-5-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=X3FEyzzOhKoLo882iTiAjwDO5tYxfLLEHDmHc5v-1fJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas / Yadwinder,

On Wed, May 29, 2013 at 6:37 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> This patch adds set_rate and round_rate clk_ops for PLL36xx
>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c |   59 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Looks good to me.  I one nit on space/vs tab after
PLL36XX_LOCK_STAT_SHIFT that would be nice to fix, but not major.

Reviewed-by: Doug Anderson <dianders@chromium.org>
