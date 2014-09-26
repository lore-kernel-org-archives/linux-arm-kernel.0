From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 26 Sep 2014 22:06:30 +0800
Subject: [PATCH] [media] rc: fix hix5hd2 compile-test issue
In-Reply-To: <20140926131229.GS5182@n2100.arm.linux.org.uk>
References: <1411571401-30664-1-git-send-email-zhangfei.gao@linaro.org>
 <1411736250-29252-1-git-send-email-zhangfei.gao@linaro.org>
 <20140926131229.GS5182@n2100.arm.linux.org.uk>
Message-ID: <542572E6.70803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/26/2014 09:12 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 26, 2014 at 08:57:30PM +0800, Zhangfei Gao wrote:
>> Add dependence to solve build error in arch like ia64
>> error: implicit declaration of function 'readl_relaxed' & 'writel_relaxed'
>>
>> Change CONFIG_PM to CONFIG_PM_SLEEP to solve
>> warning: 'hix5hd2_ir_suspend' & 'hix5hd2_ir_resume' defined but not used
>
> There is work currently in progress (in linux-next) to provide
> asm-generic accessors for the above.

Thanks Russell for the info.

Have found the patch set about "asm-generic: io: implement relaxed 
accessor macros as conditional wrappers".

That's great.

Thanks
