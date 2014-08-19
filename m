From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 19 Aug 2014 22:07:06 +0530
Subject: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
In-Reply-To: <20140819085002.GE12930@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <53F244DA.3070803@ti.com> <20140818154112.6601cbff@gandalf.local.home>
 <53F25AD1.8040504@ti.com>
 <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
 <20140819085002.GE12930@pengutronix.de>
Message-ID: <53F37D32.3080301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 August 2014 02:20 PM, Markus Pargmann wrote:
> Hi,
>
> On Tue, Aug 19, 2014 at 12:50:59AM +0200, Javier Martinez Canillas wrote:
>> Hello Mugunthan,
>>
>> On Mon, Aug 18, 2014 at 9:58 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>>> Thus, for this patchset, as is:
>>>>
>>>> Tested-by: Steven Rostedt <rostedt@goodmis.org>
>>> This will fail for DRA7xx not in AM33xx
>>>
>> cpsw_am33xx_cm_get_macid() checks for
>> of_machine_is_compatible("ti,am33xx") and returns 0 if the machine is
>> not an am33xx. cpsw_probe_dt() only propagates the return value if is
>> not 0 so this patch does not change the semantics for other SoCs
>> besides am33xx.
> Yes, this patch is only about the am33xx. I don't have the DRA7xx
> hardware so I am not able to test on that hardware. Mugunthan, perhaps
> you can supply some followup patches for DRA7xx.
>
>

I will check on this thursday and update.

Regards
Mugunthan V N
