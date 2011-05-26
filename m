From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 26 May 2011 15:07:07 +0530
Subject: [PATCH 08/15] OMAP2+: GPIO: make workaround_enabled bank specific
In-Reply-To: <874o4ipfqw.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-9-git-send-email-tarun.kanti@ti.com>
	<874o4ipfqw.fsf@ti.com>
Message-ID: <BANLkTi=sw1Dc5hP+VqGu1f9aci4WhXfz=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 04:09, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Charulatha V <charu@ti.com>
>>
>> Make workaround_enabled flag bank-specific instead of using a single
>> flag for all the banks together. This would be helpful while making
>> use of runtime framework in OMAP GPIO driver which would make the
>> driver handle each GPIO bank independently.
>>
>> Also rename workaround_enabled flag to off_mode_wkup_wa_enabled
>
> Do we even need a dedicated flag for this?
>
> I seems that the combination of enabled_non_wakeup_gpios and whether or
> not context has been lost could be used to check this condition.

Okay, will check and do the needful.

>
> Kevin
>
