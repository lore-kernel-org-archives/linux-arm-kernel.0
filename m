From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 09:51:15 +0200
Subject: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
 <20151012065323.GA3558@piout.net>
 <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
Message-ID: <20151012075115.GC3558@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 at 07:48:18 +0000, Yang, Wenyou wrote :
> > On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> > > This patch is to clear the RTC alarm status flag prior to suspending
> > > to avoid the erroneous wake-up activity.
> > >
> > 
> > Is this a new issue appearing with the sama5d2 or was it present from the
> > beginning?
> With the sama5d2 ULP1 mode, not from the beginning.
> 

I think this information should appear in the commit log.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
