From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 18 Nov 2015 22:28:19 +0800
Subject: [PATCH] of/irq: export of_irq_count
In-Reply-To: <CAL_JsqJmdLQq9a4P3ZLurjcDBhnbS8LcuLdy0MyPR49DV+3dgg@mail.gmail.com>
References: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
 <CAL_JsqJmdLQq9a4P3ZLurjcDBhnbS8LcuLdy0MyPR49DV+3dgg@mail.gmail.com>
Message-ID: <564C8B03.7080300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 10/15/2015 09:47 PM, Rob Herring wrote:
> On Thu, Oct 15, 2015 at 5:36 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>> Export of_irq_count, otherwise module build fail if of_irq_count is used
>
> Which module?

https://lkml.org/lkml/2015/11/17/572

What do you think about this patch?

There is ERROR reported from kbuild.

[auto build test ERROR on scsi/for-next]
[also build test ERROR on v4.4-rc1 next-20151116]

url: 
https://github.com/0day-ci/linux/commits/John-Garry/HiSilicon-SAS-driver/20151116-215304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git 
for-next
config: i386-allmodconfig (attached as .config)
reproduce:
         # save the attached .config to linux build tree
         make ARCH=i386

All errors (new ones prefixed by >>):

 >> ERROR: "of_irq_count" undefined!

Thanks
