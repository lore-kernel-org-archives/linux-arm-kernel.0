From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 Jul 2017 21:37:50 +0200
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <20170727120807.15148375@roar.ozlabs.ibm.com> (Nicholas Piggin's
 message of "Thu, 27 Jul 2017 12:08:07 +1000")
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home> <87o9s7qw64.fsf@belgarion.home>
 <20170726114139.GN31807@n2100.armlinux.org.uk>
 <20170726220334.2961ae22@roar.ozlabs.ibm.com>
 <87k22urjwp.fsf@belgarion.home>
 <20170727120807.15148375@roar.ozlabs.ibm.com>
Message-ID: <87fudhr7qp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicholas Piggin <npiggin@gmail.com> writes:

> Hmm, I intended to cc you, but somehow failed that too. No wonder my
> code has bugs :\
>
> It's gone to linux-kbuild and linux-arm-kernel
>
> http://marc.info/?l=linux-kbuild&m=150107320226315&q=raw
I verified your patch, it works. Could you please add :
Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
...
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
