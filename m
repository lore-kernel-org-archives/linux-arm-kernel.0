From: x0148406@ti.com (Afzal Mohammed)
Date: Tue, 16 Oct 2012 12:26:13 +0530
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <20121015160154.GB15569@atomide.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
 <20121015160154.GB15569@atomide.com>
Message-ID: <507D050D.2090402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Monday 15 October 2012 09:31 PM, Tony Lindgren wrote:
> * Mohammed, Afzal<afzal@ti.com>  [121015 05:42]:
>> On Thu, Oct 11, 2012 at 20:17:56, Tony Lindgren wrote:

>>> Yes, then please do a second pull request for what's needed
>>> to apply the minimal DT bindings. For the DT binding, let's
>>> just leave out the timings for now as we can load those from
>>> auxdata. Then the binding for the timings can be added
>>> later on. So just the minimal binding using standard features
>>> for the iorange and interrupt.

>> Ok, I will keep timings aside for now and proceed with DT
>> (avoiding auxdata usage with generic routine looked to me a
>> saner approach though, with an initial DT'fy delay)

> Oh well if you think it's easier to do the timings too in
> the DT binding, please go ahead with that. It may take some
> longer discussion on the lists for the binding though. But
> up to you.

I certainly don't think it is easier, rather tougher, cleaner
as well. One thing that worried me was, if we pursue the
auxdata path (a last resort option) and later if it is
objected, we would be back to square one.

Let me discuss internally and get back.

Regards
Afzal
