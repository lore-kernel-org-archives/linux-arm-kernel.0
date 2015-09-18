From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 18 Sep 2015 14:12:13 +0100
Subject: Recent GIC v1 patch
In-Reply-To: <20150918120851.6f9fb306@arm.com> (Marc Zyngier's message of
 "Fri, 18 Sep 2015 12:08:51 +0100")
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
 <55FAF6E1.7020107@free.fr> <55FAFD3E.7010006@arm.com>
 <55FBD6F4.8030905@free.fr> <20150918120851.6f9fb306@arm.com>
Message-ID: <yw1xbnczub0y.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> No idea so far. The only thing I can immediately spot is a missing pair
> of chained_irq_{enter,exit} in tangox_irq_handler, but I can't imagine
> this having a terminal effect on the system.

Fixed in the tangox tree on github.

-- 
M?ns Rullg?rd
mans at mansr.com
