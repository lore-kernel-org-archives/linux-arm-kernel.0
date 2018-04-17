From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 17 Apr 2018 10:29:09 -0700
Subject: [RESEND PATCH v2 0/4] ARM: davinci: remove the mach-specific
 aemif driver - part 1
In-Reply-To: <CAMpxmJUBFEF7FDp910HwsrNhGhwJDrgRR_9qL0DE5W1M=39MgQ@mail.gmail.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <2a2ac117-900c-77b6-f247-49777493e55f@ti.com>
 <CAMpxmJUBFEF7FDp910HwsrNhGhwJDrgRR_9qL0DE5W1M=39MgQ@mail.gmail.com>
Message-ID: <e3fc3019-888c-cbc3-5e1b-e24c30bc4d49@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2018 5:36 AM, Bartosz Golaszewski wrote:
> 2018-04-17 12:53 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>> Hi Bartosz,

[...]

>>> This series applies on top of v8 of David Lechner's CCF series.
>>
>> Are there any patches in the series that can safely be applied to v4.17-rc1?

> 
> Hi Sekhar,
> 
> yes, all of them. They're not linked to David's work in any way.
> 
Please separate the driver/emif/* patches from the series. These
are not fixes so they are not rcx candidates. But will queue them
up for next merge window. Thanks !!
