From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 18 May 2014 14:08:02 +0200
Subject: [PATCH] arm/omap4: add twd clock to DT
In-Reply-To: <535662F0.4080300@ti.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <20140418223948.GK21823@atomide.com> <5353F44F.5080400@xenomai.org>
 <535662F0.4080300@ti.com>
Message-ID: <CAGhQ9Vw-QaB+OnLa3yNVvD6a=XOutSZ1ejbsuUXvEcyrxEsRcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2014 14:39, Tero Kristo <t-kristo@ti.com> wrote:
> On 04/20/2014 07:22 PM, Gilles Chanteperdrix wrote:
>>
>> Le 19/04/2014 00:39, Tony Lindgren a ?crit :
>>>
>>> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [140407 13:09]:
>>>>
>>>> Booting Linux 3.14 on Pandaboard currently gets the following
>>>> message displayed:
>>>>
>>>> smp_twd: clock not found -2
>>>>
>>>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoid this.
>>>
>>>
>>> Tero, care to ack?
>>
>>
>> Sorry if I did not mail the right people, get_maintainer.pl gave me a
>> long list, and I did not feel like spamming all these people for such a
>> small patch. I do not believe Tero was in this list.
>>
>> Regards.
>
>
> Yea I don't think this is my expertise area, however the patch looks good to
> me, so if you really need it:
>
> Acked-by: Tero Kristo <t-kristo@ti.com>

Tony, care to add this to your omap 3.16 dt branch?

I am still getting:
[ 0.000152] smp_twd: clock not found -2

So this fix from Gilles would be nice to have.

regards
Joachim Eastwood
