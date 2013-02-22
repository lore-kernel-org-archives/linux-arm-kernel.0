From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Feb 2013 11:24:00 +0100 (CET)
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <5127436E.4040100@ti.com>
References: <CAB4PhKevqf0e4nzYraE9ZTAFbPCFfNpguAnPoVpJh-FFe2TAZA@mail.gmail.com>
 <alpine.LFD.2.02.1302201400400.22263@ionos>
 <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
 <alpine.LFD.2.02.1302211015270.22263@ionos>
 <CAB4PhKf+Z-TK4KGDZm1kYOWibg=e2Ehnhjxt_oTbFq9eqouAjA@mail.gmail.com>
 <alpine.LFD.2.02.1302211436300.22263@ionos> <51263975.20906@ti.com>
 <alpine.LFD.2.02.1302212214020.22263@ionos> <5127436E.4040100@ti.com>
Message-ID: <alpine.LFD.2.02.1302221122290.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Feb 2013, Santosh Shilimkar wrote:
> BTW, Lorenzo off-list mentioned to me about warning in boot-up
> which I missed while testing your patch. It will take bit more
> time for me to look into it and hence thought of reporting it.
> 
> [    2.186126] ------------[ cut here ]------------
> [    2.190979] WARNING: at kernel/time/tick-broadcast.c:501
> tick_broadcast_oneshot_control+0x1c0/0x21c()

Which one is that? tick_broadcast_pending or tick_force_broadcast_mask ?
