From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 15:15:11 -0700
Subject: [PATCH v1 1/1] clk: npcm750: fix base address and
 of_clk_get_by_name
 error handling. Also update error messages to be more informative
In-Reply-To: <1525159407-31708-2-git-send-email-tali.perry1@gmail.com>
References: <1525159407-31708-1-git-send-email-tali.perry1@gmail.com>
 <1525159407-31708-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <152642251190.237094.2880285895652897578@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tali Perry (2018-05-01 00:23:27)
> 
> Nuvoton NPCM7XX Clock Controller
> fix base address and of_clk_get_by_name error handling.
>     Also update error messages to be more informative.
>     
>     In case clk_base allocation is erronoeous the return value is null.
>     Also fix handling of of_clk_get_by_name returns an error. 
>     Print a better error message pointing to the dt-binding documention.
> 
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Tali Perry (2):
>  

This doesn't apply to clk-next so I'm not sure what's going on. Please
resend if something needs to be fixed.
