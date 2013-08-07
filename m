From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 Aug 2013 11:03:41 +0200
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1375828754.12557.70.camel@pasglop>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806201000.3e97c63b@skate> <1375828754.12557.70.camel@pasglop>
Message-ID: <20130807110341.4be97aa8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Benjamin Herrenschmidt,

On Wed, 07 Aug 2013 08:39:14 +1000, Benjamin Herrenschmidt wrote:

> > Would you mind having a look at:
> > 
> >  * Patches 4, 5, 6, 7 for Benjamin as the irqdomain maintainer.
> 
> Ah sorry, I wasn't aware you were actually waiting for my acks, I didn't
> read the whole thread, my bad. I'm not irqdomain maintainer btw.

Hum, interesting. This is not what my 3.11-rc3 kernel tree says:

IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
M:      Benjamin Herrenschmidt <benh@kernel.crashing.org>
S:      Maintained

As of a0062d4e3a0a ('MAINTAINERS: Remove Grant Likely'), Grant resigned
as the maintainer of IRQ DOMAINS, so you are now the only maintainer
for this subsystem.

> I wrote the original powerpc implementation but since then it has been taken
> over by Grant and others. But I can certainly comment :-)

As the official maintainer, your comments would certainly be
appreciated.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
