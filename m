From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 17 Nov 2011 15:53:05 +0800
Subject: arm pmu interrupt on pandaboard
In-Reply-To: <1321513474.40681.YahooMailNeo@web125720.mail.ne1.yahoo.com>
References: <1321513474.40681.YahooMailNeo@web125720.mail.ne1.yahoo.com>
Message-ID: <CACVXFVOirXk63bxNbkAAoVg2syQAKkXL_zL4ONbkh9uZfaw55A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 17, 2011 at 3:04 PM, Fan Ye <mouseyefan@yahoo.com> wrote:
> Hi Tom,
> I am currently working on PMU interrupt on Pandaboard.I use the patch sent
> by you:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045283.html
>
> But it will fail to boot the kernel. So I also apply the following patch:
> http://lists.linaro.org/pipermail/linaro-dev/2011-April/004019.html
>
> Now the kernel can boot up successfully. But I find that PMU interrupt is
> not?triggered?even if the PMU overflow happens and the interrupt is enabled
> in the?PMINTENSET register.

I have posted some new code about the issue, see

       http://marc.info/?t=131946776600001&r=1&w=2

I think this one can make your pmu work, :-)

> The code base I am using is
> http://git.linaro.org/gitweb?p=kernel/linux-linaro-2.6.39.git;a=summary
> Thank you very much.
> Ye Fan
>

thanks,
-- 
Ming Lei
