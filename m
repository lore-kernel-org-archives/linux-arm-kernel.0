From: nm@ti.com (Nishanth Menon)
Date: Mon, 7 Jul 2014 09:23:23 -0500
Subject: [PATCH V2] ARM: dts: OMAP5: Add device nodes for ABB
In-Reply-To: <20140707113220.GQ28884@atomide.com>
References: <1402017072-12599-1-git-send-email-nm@ti.com>
 <20140707113220.GQ28884@atomide.com>
Message-ID: <CAGo_u6peyH=VScObgLJxX5kS2J77y5WMsE0O71W4GPDpKaMV=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 7, 2014 at 6:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nishanth Menon <nm@ti.com> [140605 18:12]:
>> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
>>
>> Add ABB device nodes for OMAP5 family of devices. Data is based on
>> final production OMAP543x Technical Reference Manual revision Z (April 2013).
>> Final production Data Manual for OMAP5432 SWPS050F(APRIL 2014).
>>
>> [nm at ti.com: co-developer and updates to latest documentation]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
>> ---
>> Original patch (v1): https://patchwork.kernel.org/patch/3555191/
>>
>> Rest of the series was accepted, however, I had to drop this
>> previously to ensure that the data we introduce is compatible with
>> production samples and existing pre-production samples on various
>> OMAP5uEVMs already in circulation.
>
> Is this OK to queue for v3.17 or do we need it for the -rc cycle?
>

.17 should be fine Tony. Thanks for following up.

Regards,
Nishanth Menon
