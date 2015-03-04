From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 11:22:37 +0100
Subject: [PATCH] ARM: at91/dt: keep watchdog running in idle mode
In-Reply-To: <20150304101828.GA7983@gradator.net>
References: <549954F7.9070009@objectxp.com>
 <20150304101828.GA7983@gradator.net>
Message-ID: <54F6DCED.3050708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/03/2015 11:18, Sylvain Rochet a ?crit :
> Hello Nicolas, Michel,
> 
> On Tue, Dec 23, 2014 at 12:41:43PM +0100, Michel Marti wrote:
>> Since turning on idle-halt in commit fe46aa679, SoCs compatible with
>> the sam9 watchdog no longer reboot if the wdt times out. Removing the
>> 'idle-halt' flag fixes this.
> 
> I missed that and I did exactly the same recently in my "[PATCHv2 0/2] 
> dts: AT91 Watchdog, remove property idle halt by default", first come, 
> first serve:
> 
> Acked-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> 
> But my patch summary is IMHO better (even with my broken english ;-).

I try to take it for at91-4.0-at91 and mix the 2 commit messages.
+ I take your documentation of the DT property.

Thanks, bye,
-- 
Nicolas Ferre
