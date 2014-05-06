From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 17:07:49 +0200
Subject: [PATCH v2 1/9] ARM: S3C24XX: cpufreq-utils: don't write raw values
 to MPLLCON when using ccf
In-Reply-To: <0e4501cf68e3$8f6612d0$ae323870$@samsung.com>
References: <2104342.rkElQpXtvM@phil> <535825AB.8060802@cogentembedded.com>
 <535828D7.3080301@gmail.com> <1538030.0aVnFA3MgQ@phil>
 <0e4501cf68e3$8f6612d0$ae323870$@samsung.com>
Message-ID: <5368FAC5.4010801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

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
>
> Heiko, thanks for the v2.1 as well.

Just found time to look through this series and it looks fine. So if not 
applied yet, feel free to add

Acked-by: Tomasz Figa <t.figa@samsung.com>

to clk: patches.

Also we still need to ping DT maintainers, as they should ask patch 4/9 
before it is merged.

Best regards,
Tomasz
