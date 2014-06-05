From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 5 Jun 2014 12:57:58 +0100
Subject: [STLinux Kernel] [PATCH RESEND 12/12] drivers: clk: st: Use
 round to closest divider flag
In-Reply-To: <1401892320-18211-13-git-send-email-gabriel.fernandez@linaro.org>
References: <1401892320-18211-1-git-send-email-gabriel.fernandez@linaro.org>
 <1401892320-18211-13-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140605115758.GB2294@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Gabriel FERNANDEZ wrote:

> This patch uses CLK_DIVIDER_ROUND_CLOSEST flag to specify
> the divider has to round to closest div.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  drivers/clk/st/clkgen-mux.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Peter Griffin <peter.griffin@linaro.org>

Regards,

Peter
