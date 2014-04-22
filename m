From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 22 Apr 2014 15:39:12 +0300
Subject: [PATCH] arm/omap4: add twd clock to DT
In-Reply-To: <5353F44F.5080400@xenomai.org>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <20140418223948.GK21823@atomide.com> <5353F44F.5080400@xenomai.org>
Message-ID: <535662F0.4080300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2014 07:22 PM, Gilles Chanteperdrix wrote:
> Le 19/04/2014 00:39, Tony Lindgren a ?crit :
>> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [140407 13:09]:
>>> Booting Linux 3.14 on Pandaboard currently gets the following
>>> message displayed:
>>>
>>> smp_twd: clock not found -2
>>>
>>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoid this.
>>
>> Tero, care to ack?
>
> Sorry if I did not mail the right people, get_maintainer.pl gave me a
> long list, and I did not feel like spamming all these people for such a
> small patch. I do not believe Tero was in this list.
>
> Regards.

Yea I don't think this is my expertise area, however the patch looks 
good to me, so if you really need it:

Acked-by: Tero Kristo <t-kristo@ti.com>
