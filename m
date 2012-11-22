From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 22 Nov 2012 13:51:51 +0900
Subject: [PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System
 MMU
In-Reply-To: <50ACF847.3070709@samsung.com>
References: <002801cdc7a5$8535f6d0$8fa1e470$%cho@samsung.com>
 <50ACF847.3070709@samsung.com>
Message-ID: <CAHQjnOMSB+0SrNAfrJdXo_MWCHjEULWVzyEejcOWxWeT73sZfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 12:50 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 11/21/12 14:03, Cho KyongHo wrote:
>>
>> Touching some System MMU needs its master devices' clock to be enabled
>> before. This commit adds clk_ops.set_parent of gating clocks of System
>> MMU to ensure gating clocks of System MMU's mater devices are enabled
>> when enabling gating clocks of System MMU.
>>
>> Change-Id: Icd58b12f599e92692c032516331a444f4703ba6b
>
>
> Same here, we don't need this :-)
>
>
>> Signed-off-by: KyongHo Cho<pullip.cho@samsung.com>
>> ---
>>   arch/arm/mach-exynos/clock-exynos5.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>
> Looks good to me, and I think, this can be applied independently from this
> series. Will apply with removing 'Change-Id'.
>
Yes. I missed that.
It will be removed.

Thank you.

Cho KyongHo
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/ab795569/attachment-0001.html>
