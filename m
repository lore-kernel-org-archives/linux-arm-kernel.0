From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Jan 2014 07:36:31 +0000
Subject: [PATCH 2/2] clk: ux500: Staticize ux500_twocell_get
In-Reply-To: <1389764606-14102-2-git-send-email-sachin.kamat@linaro.org>
References: <1389764606-14102-1-git-send-email-sachin.kamat@linaro.org>
 <1389764606-14102-2-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140115073631.GD11820@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ux500_twocell_get is a local symbol.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/clk/ux500/u8500_of_clk.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
