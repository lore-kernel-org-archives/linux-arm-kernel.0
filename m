From: bcousson@baylibre.com (Benoit Cousson)
Date: Fri, 11 Oct 2013 21:31:09 +0200
Subject: [PATCH] ARM: DRA: DTS: Remove clock-frequency field for cpu timers
In-Reply-To: <5256A76F.2080503@ti.com>
References: <1381391413-4361-1-git-send-email-r.sricharan@ti.com>
 <5256A76F.2080503@ti.com>
Message-ID: <525851FD.9040803@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sricharan,

On 10/10/2013 15:11, Santosh Shilimkar wrote:
> On Thursday 10 October 2013 03:50 AM, Sricharan R wrote:
>> The arm arch timers frequency are now programmed in the CNTFREQ
>> per-cpu register by the timer code using the secure API [1].
>> So remove the redundant entry from the dts.
>>
>> [1] http://marc.info/?l=linux-omap&m=138139106312786&w=2
>>
>> Cc: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>

I've just applied it for 3.13.

Thanks,
Benoit
