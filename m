From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 May 2014 18:09:24 +0200
Subject: [PATCH 1/5] ARM: S5PV210: Remove camera support from mach-goni.c
In-Reply-To: <081001cf65cc$cbef8700$63ce9500$@samsung.com>
References: <1397583272-28295-1-git-send-email-s.nawrocki@samsung.com>
 <1397583272-28295-2-git-send-email-s.nawrocki@samsung.com>
 <081001cf65cc$cbef8700$63ce9500$@samsung.com>
Message-ID: <536BAC34.2020904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/14 08:07, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>> > 
>> > S5PV210 is going to get DT support, so we can remove the camera
>> > bits from the only board using camera on S5PV210. This allows to
>> > clean the exynos4-is driver by dropping code for non-dt platforms.
>> > This patch can be dropped if a patch removing the whole board
>> > file is applied first.
>> > 
>> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Hi Sylwester,
> 
> Cleanup is always welcome ;-)
> 
> I think, when this series is ready for mainline, this will be handled in
> media tree. So,
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Kukjin,

Thank you, patch queued up for the media tree!

--
Regards,
Sylwester
