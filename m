From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Jul 2014 21:38:30 +0200
Subject: [PATCH 2/4] dts: add devicetree bindings for pxa27x clocks
In-Reply-To: <20140703220328.11380.22037@quantum> (Mike Turquette's message of
 "Thu, 03 Jul 2014 15:03:28 -0700")
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
 <1404066744-13416-3-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZys4k6g5RgPLbreopOxTwDJ+bfPOq8XPwsNpyt5+YURjg@mail.gmail.com>
 <20140703220328.11380.22037@quantum>
Message-ID: <87d2dkoqx5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Haojian Zhuang (2014-07-02 23:14:33)
>> Maybe defining these clocks in pxa27x clock driver is better.
>
> Agreed. After a long time trying to figure out the best DT binding for
> clocks it seems that defining the per-clock data in DTS is not the best
> way. The qcom msm and samsung exynos clock bindings and DTS data are
> good examples.

Ah, I see. Would have been a great comment in the former RFC patch serie, sic
... Maybe a comment in the clock device-tree documentation would prevent others
to do the same error ?

Well, it will take me some time to transform the dts data into code, especially
if I want to have some genericity to handle all PXA variants.

I'll work on it in the next days/week.

Cheers.

-- 
Robert
