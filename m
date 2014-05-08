From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 08 May 2014 19:36:10 +0200
Subject: [PATCH v2 1/9] ARM: S3C24XX: cpufreq-utils: don't write raw values
 to MPLLCON when using ccf
In-Reply-To: <0e4501cf68e3$8f6612d0$ae323870$@samsung.com>
References: <2104342.rkElQpXtvM@phil> <535825AB.8060802@cogentembedded.com>
 <535828D7.3080301@gmail.com> <1538030.0aVnFA3MgQ@phil>
 <0e4501cf68e3$8f6612d0$ae323870$@samsung.com>
Message-ID: <536BC08A.6000006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 06.05.2014 06:27, Kukjin Kim wrote:
> Heiko St?bner wrote:
>>
> 
> [...]
> 
>>> Anyway, Heiko, thanks for working on this. I'll try to review rest of
>>> the series soon. (I'm attending the ELC next week, though, so I'm not
>>> sure if I find some time then, though.)
>>
> Yeah, this series is really good to us.
> 
>> Just as a reminder, there isn't this much to still review, as you
>> Acked/Reviewed most of the series in v1 and only this patch as well as 2
>> and 5
>> still need a review/ack - and the only changes are fixes for your
>> comments ;-)
>>
> I think so. Since I will apply this series in this week, if any big
> comments, please let us know.

This needs to be synchronized with series for Exynos5260 and support for
multiple clock providers. Let me prepare a branch for you to pull from
my tree with all necessary dependencies.

Best regards,
Tomasz
