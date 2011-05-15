From: dv@vollmann.ch (Detlef Vollmann)
Date: Sun, 15 May 2011 17:08:38 +0200
Subject: Kernel oops with undefined instruction when accessing memory
	on an	AT91 custom system
In-Reply-To: <4DCF4DF5.8020004@usask.ca>
References: <4DCEADB5.9010905@usask.ca> <4DCEF71A.9050405@vollmann.ch>
	<4DCF4DF5.8020004@usask.ca>
Message-ID: <4DCFEC76.9050504@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/11 05:52, Nicholas Kinar wrote:
> Detlef Vollmann wrote:

>> I haven't had the time yet to hunt this down, but I propose you
>> turn on DEBUG_VM and BUG and see whether you get more consistent oopses.

> Thanks for your response, Detlef. It appears that the AT91 mmc driver is
> a little bit more stable now with debugging turned off. The kernel oops
> still continues as documented in my response to Nicolas Ferre, but I
> think that the debugging should indeed be turned off in a production
> system.
My point was not that you should turn on debugging in a production
system, my point was that you should turn on debugging features for
debugging the problem.
Turning on debugging features will quite probably not introduce new
problems -- it will just show you problems much earlier and much
nearer to the original cause, so it's much easier to find that original
cause.

   Detlef
