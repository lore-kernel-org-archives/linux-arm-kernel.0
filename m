From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 21 May 2012 15:13:17 +0530
Subject: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
In-Reply-To: <1337593097.28274.19.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com> <871umj4qnl.fsf@ti.com>
 <1337593097.28274.19.camel@sokoban>
Message-ID: <CAMQu2gw4XwO_pAHnHNzwY_xQ4_tHS7a3iAFMxLL1ddV8xHwPvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 3:08 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 17:06 -0700, Kevin Hilman wrote:
>> +Benoit
>>
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>> > otherwise the secure ROM code will crash.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>
>> I think I mentioned this already (I'm already lost in what I've said for
>> thisseries), but I don't think the secure RAM stuff belongs in the
>> wakeupgen driver.
>
> As mentioned, save_secure_all saves:
> - secure RAM
> - GIC registers
> - some other mysterious stuff
(mysterious:  Entire firewall registers )

Regards
Santosh
