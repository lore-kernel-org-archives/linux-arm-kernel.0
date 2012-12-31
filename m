From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 31 Dec 2012 18:40:46 +0530
Subject: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
In-Reply-To: <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
References: <20121230182745.30526.47072.stgit@dusk.lan>
 <20121230182829.30526.32914.stgit@dusk.lan> <50E14C12.5020105@ti.com>
 <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
Message-ID: <50E18ED6.30802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:26 PM, Paul Walmsley wrote:
> Hi
>
> On Mon, 31 Dec 2012, Santosh Shilimkar wrote:
>
>> This is more of question. If the limitation is w.r.t MPU power
>> state then shouldn't we just prevent the MPU power state rather
>> than blocking the WFI completely.
>>
>> Can you please clarify if retaining MPU power state in ON can achieve
>> the same results ?
>
> In these cases, it's blocking WFI that is apparently needed.  I know it
> doesn't make much sense.
>
Ya. It doesn't make sense but if that is the case then the patch make
sense :-)

Thanks for clarification !!

Regards
Santosh
