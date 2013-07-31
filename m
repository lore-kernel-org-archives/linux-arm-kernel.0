From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Jul 2013 20:37:21 -0700
Subject: [PATCH 08/11] clk: tegra114: add suspend/resume function for
 tegar_cpu_car_ops
In-Reply-To: <1375237637.1231.1.camel@jlo-ubuntu-64.nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-9-git-send-email-josephl@nvidia.com>
 <20130730212100.5270.53947@quantum>
 <1375237637.1231.1.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <CAPtuhTgsU0mr0ARK1WT=670ct5R158B5eAz3TwWkM-hL+X-hVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 7:27 PM, Joseph Lo <josephl@nvidia.com> wrote:
> On Wed, 2013-07-31 at 05:21 +0800, Mike Turquette wrote:
>> Quoting Joseph Lo (2013-06-25 02:27:52)
>> > Adding suspend/resume function for tegra_cpu_car_ops. We only save and
>> > restore the setting of the clock of CoreSight. Other clocks still need
>> > to be taken care by clock driver.
>> >
>> > Cc: Mike Turquette <mturquette@linaro.org>
>> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>
>> Change looks OK to me, besides Stephen's comments. I was waiting for a
>> V2 to hit the list but I never saw it. Any plans?
>>
> Hi Mike,
>
> The V2 was sent on 2013/7/3.

Ok, looks like Stephen took it into his branch.

Thanks,
Mike

>
> Thanks,
> Joseph
>
>
