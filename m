From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 25 May 2013 00:20:05 +0200
Subject: [RESEND PATCH 4/5] clk: samsung: Add set_rate() clk_ops for
 PLL36xx
In-Reply-To: <1369391478-7665-5-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
 <1369391478-7665-5-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <2497806.WgtiTKYQrX@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 24 of May 2013 16:01:17 Vikas Sajjan wrote:
> This patch adds set_rate and round_rate clk_ops for PLL36xx
> The round_rate() implementation as of now is dummy, it returns the same
> rate which is passed as input.
> 
> Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> ---
>  drivers/clk/samsung/clk-pll.c |   67
> +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 67
> insertions(+)
> 

I have exactly the same comments for this patch as for patch 3/5.

Best regards,
Tomasz
