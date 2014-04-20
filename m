From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sun, 20 Apr 2014 18:22:39 +0200
Subject: [PATCH] arm/omap4: add twd clock to DT
In-Reply-To: <20140418223948.GK21823@atomide.com>
References: <1396901139-17268-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <20140418223948.GK21823@atomide.com>
Message-ID: <5353F44F.5080400@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/04/2014 00:39, Tony Lindgren a ?crit :
> * Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> [140407 13:09]:
>> Booting Linux 3.14 on Pandaboard currently gets the following
>> message displayed:
>>
>> smp_twd: clock not found -2
>>
>> Define "mpu_periphclk" as the twd clock in omap4 dts to avoid this.
> 
> Tero, care to ack?

Sorry if I did not mail the right people, get_maintainer.pl gave me a
long list, and I did not feel like spamming all these people for such a
small patch. I do not believe Tero was in this list.

Regards.


-- 
Gilles.
