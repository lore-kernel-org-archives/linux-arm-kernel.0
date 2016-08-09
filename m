From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 09 Aug 2016 12:58:49 +0200
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <C2BE77CA-A59B-4128-8802-E3E36FACDABA@rock-chips.com>
References: <1549971.ctkvOGm2xW@diego>
 <CAFLEztTROearSEcgzV3EVHFcRcMQpLhAQ6BXP-dDyRDAWybaxg@mail.gmail.com>
 <C2BE77CA-A59B-4128-8802-E3E36FACDABA@rock-chips.com>
Message-ID: <13761657.UM4fvlJBBq@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 9. August 2016, 18:06:33 schrieb Randy Li:
> ??? iPad ??
> 
> > ?? <jacobchen110@gmail.com> ? 2016?8?9? ??6:02 ???
> > 
> > well?it has already been added....
> > 
> > The root cause is not act8846. Firefly have a bug with sdmmc and it
> > seems they didn't fix it in firefly-reload.
> > 
> > http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=256

Thanks Jacob for pointing out this issue - I was always wondering why it 
wasn't working :-) .


> Yes, Jacob is right. Those high speed options need the voltage down to 1.8v.
> They should be removed.

Randy, can you provide a follow-up patch that removes these excess properties 
please?


Thanks
Heiko
