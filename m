From: tyler.baker@linaro.org (Tyler Baker)
Date: Fri, 19 Dec 2014 13:25:11 -0800
Subject: kernel.org - master not booting on keystone (ARM v7 Cortex A15
 SoC) EVMs
In-Reply-To: <20141219211816.GH10857@pengutronix.de>
References: <549490D6.3090804@ti.com> <20141219211816.GH10857@pengutronix.de>
Message-ID: <CANMBJr5T6SJFiw4HwvK0cfJsyrM8WTPU6_aK0uzznEV4Mqcg3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 19 December 2014 at 13:18, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Dec 19, 2014 at 03:55:50PM -0500, Murali Karicheri wrote:
>> I have pulled the latest master from
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and
>> tried booting on keystone k2hk and k2e EVM. The boot hangs with
>> following log. Has anyone seen this? Keystone is an ARM v7 cortex
>> A15 SMP platform. I am assuming master branch is broken for ARM v7
>> and someone is working to address this. v3.18 booted up fine on my
>> EVM.
>>
>> Any idea?
> You forgot to attach the log?! So no, I don't have any idea. Did you
> bisect?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Could you share your u-boot configuration?
