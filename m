From: chris@printf.net (Chris Ball)
Date: Fri, 17 Jan 2014 15:01:24 +0000
Subject: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
In-Reply-To: <002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com> (Seungwon
 Jeon's message of "Tue, 14 Jan 2014 19:42:19 +0900")
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
 <002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com>
Message-ID: <86sism7iuz.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 14 2014, Seungwon Jeon wrote:
> On Monday, January 13, 2014, Zhangfei Gao wrote:
>> Remove clk_table and directly use ios->clock as clock source rate.
>> Abstract init clock rate and max clock limitation in clk.c
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

It looks like patch 1/2 did not make 3.14.  Do you want me to take
this patch for 3.14 anyway?  (Why?)

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
