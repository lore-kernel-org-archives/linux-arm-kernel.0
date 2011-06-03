From: khilman@ti.com (Kevin Hilman)
Date: Fri, 03 Jun 2011 07:31:45 -0700
Subject: [PATCH 15/15] OMAP: GPIO: clean omap_gpio_mod_init function
In-Reply-To: <BANLkTi=e1PowoD7er46g1q+8EOqLfJNGTQ@mail.gmail.com> (Charulatha
	Varadarajan's message of "Fri, 3 Jun 2011 16:50:02 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-16-git-send-email-tarun.kanti@ti.com>
	<87r57mjq9d.fsf@ti.com>
	<BANLkTi=e1PowoD7er46g1q+8EOqLfJNGTQ@mail.gmail.com>
Message-ID: <87d3ivkmum.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Thu, May 26, 2011 at 05:18, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> From: Charulatha V <charu@ti.com>
>>>
>>> With register offsets now defined for respective OMAP versions
>>> we can get rid of cpu_class_* checks. In addition, organized
>>> common initialization for the different OMAP silicon versions.
>>>
>>> Signed-off-by: Charulatha V <charu@ti.com>
>>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>>
>> The sysconfig stuff in this patch should be removed. ?In fact, now that
>> hwmod is used to manage all the GPIO IP blocks, the driver should not be
>> touching sysconfig at all.
>
> The sysconfig stuff in this patch is for OMAP16XX.
>

Ah, OK.  Sorry I missed that.

Kevin
