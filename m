From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 12 Oct 2015 07:55:13 +0000
Subject: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
In-Reply-To: <20151012075115.GC3558@piout.net>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
 <20151012065323.GA3558@piout.net>
 <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
 <20151012075115.GC3558@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641D632214D@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2015?10?12? 15:51
> To: Yang, Wenyou
> Cc: Alessandro Zummo; Ferre, Nicolas; Desroches, Ludovic; rtc-
> linux at googlegroups.com; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
> suspending
> 
> On 12/10/2015 at 07:48:18 +0000, Yang, Wenyou wrote :
> > > On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> > > > This patch is to clear the RTC alarm status flag prior to
> > > > suspending to avoid the erroneous wake-up activity.
> > > >
> > >
> > > Is this a new issue appearing with the sama5d2 or was it present
> > > from the beginning?
> > With the sama5d2 ULP1 mode, not from the beginning.
> >
> 
> I think this information should appear in the commit log.
I will add it in the next version, thanks.

> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

Best Regards,
Wenyou Yang
