From: nm@ti.com (Menon, Nishanth)
Date: Thu, 24 May 2012 08:09:33 -0500
Subject: [PATCH] ARM: OMAP3+: dpll: optimize noncore dpll locking logic
In-Reply-To: <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
References: <1337369838-15185-1-git-send-email-nm@ti.com>
 <alpine.DEB.2.00.1205240147510.2572@utopia.booyaka.com>
Message-ID: <CAOMWX4c7T+8TcnjvcMonEQwAbpBFJXRhiBu_cu4i36W81AgLWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 2:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Nishanth
>
> On Fri, 18 May 2012, Nishanth Menon wrote:
>
>> From: Vikram Pandita <vikram.pandita@ti.com>
>>
>> If the dpll is already locked, code can be optimized
>> to return much earlier than doing redundent set of lock mode
>> and wait on idlest.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Jon Hunter <jon-hunter@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Mike Turquette <mturquette@ti.com>
>> Cc: linux-omap at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>
> Did you intend to add your Signed-off-by: to this patch?

Other than forwarding the patch over(since it seems to have slipped
through the fingers of folks monitoring the product trees), I have had
no other contributions to the patch.

> Also, just FYI, no need to add the Cc: lines for the mailing lists in the
> bottom of the patch description.
>
Thanks. point taken. will take care of that in future patches.

Regards,
Nishanth Menon
