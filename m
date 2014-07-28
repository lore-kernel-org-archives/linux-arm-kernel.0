From: emilio@elopez.com.ar (=?windows-1252?Q?Emilio_L=F3pez?=)
Date: Mon, 28 Jul 2014 12:50:13 -0300
Subject: [PATCH -next] clk: sunxi: sun6i-apb0: fix sparse non static symbol
 warning
In-Reply-To: <1406554063-30350-1-git-send-email-weiyj_lk@163.com>
References: <1406554063-30350-1-git-send-email-weiyj_lk@163.com>
Message-ID: <53D67135.1060801@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 28/07/14 a las 10:27, weiyj_lk at 163.com escibi?:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fixes the following sparse warnings:
>
> drivers/clk/sunxi/clk-sun6i-apb0.c:60:27: warning:
>   symbol 'sun6i_a31_apb0_clk_dt_ids' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>


I sent patches earlier today to fix this and other sparse warnings, 
please see

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275680.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275681.html

Cheers,

Emilio
