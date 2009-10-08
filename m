From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Thu, 8 Oct 2009 10:16:59 +0200
Subject: i.MX31 kernel panic and irq
In-Reply-To: <4ACCA94B.60708@billgatliff.com>
References: <20091007132051.GB11371@n2100.arm.linux.org.uk>
	<4ACCA94B.60708@billgatliff.com>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E11@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi @all.


@Bill

> Well, "random" when you have limited information.  :) 

You're right of course :-)

> I wonder how it fares at 1kHz?

Results from 1kHz:
20 min. and running ...
Also did produce some load: make on small project +
top over ssh with d=0.1. Went without crash.

> Boy, I sure hope you don't also need a predictable interrupt latency.  
> It sounds like the system will definitely fall behind during those
> bursts.

Well.... sort of. But I failed to mention, that this project is also an
investigation on how fast / good the planned stuff works. So if the
result is, that it's reliable only with a pre-divider (of, say 512 ->
200kHz/512) well then that's the result :-)

I was really wondering about the kernel panic. Coz for being a non
real time system (I didn't change anything in that direction on my kernel)
I would have expected it to 'randomly' (on load situations) miss IRQs
but not crash the kernel?


@Russell

> The question, therefore, is why r5 would be corrupted.

Is that something I could have broken with some sort of '.config' switch?


Thanks for your help :-)

Cheers
Rene 


Rene Wolf
LFK-Lenkflugk?rpersysteme GmbH
Human Resources Operations & Policy, HRO
Landshuter Stra?e 26, 85716 Unterschlei?heim, GERMANY
Phone: +49 89 3179 8337
Fax: +49 8252 99 8964
E-Mail: rene.wolf at mbda-systems.de

http://www.mbda.net

Chairman of the Supervisory Board: Antoine Bouvier
Managing Director: Werner Kaltenegger
Registered Office: Schrobenhausen
Commercial Register: Amtsgericht Ingolstadt, HRB 4365
