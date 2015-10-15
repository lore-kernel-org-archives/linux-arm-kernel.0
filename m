From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 15 Oct 2015 21:52:38 +0800
Subject: [PATCH] of/irq: export of_irq_count
In-Reply-To: <CAL_JsqJmdLQq9a4P3ZLurjcDBhnbS8LcuLdy0MyPR49DV+3dgg@mail.gmail.com>
References: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
 <CAL_JsqJmdLQq9a4P3ZLurjcDBhnbS8LcuLdy0MyPR49DV+3dgg@mail.gmail.com>
Message-ID: <561FAFA6.4080602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rob

On 10/15/2015 09:47 PM, Rob Herring wrote:
> On Thu, Oct 15, 2015 at 5:36 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>> Export of_irq_count, otherwise module build fail if of_irq_count is used
>
> Which module?

We are developing sas driver for hisilicon hip660 platform.
We using of_irq_count to get irq number, since there are many irqs.
When we testing with build module, find build error since of_irq_count 
is not exported.

Thanks
