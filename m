From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 10 Apr 2011 08:24:21 +0000
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <BANLkTikL+GvaKN6nT-9WjpPjaJz0dR51KQ@mail.gmail.com>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop> <20110410080159.GB2798@ucw.cz>
	<BANLkTikL+GvaKN6nT-9WjpPjaJz0dR51KQ@mail.gmail.com>
Message-ID: <20110410082420.GA1460@localhost.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> >+config BCMAI_HOST_PCI_POSSIBLE
> >> >+ ? ? ? bool
> >> >+ ? ? ? depends on BCMAI && PCI = y
> >> >+ ? ? ? default y
> >> >+
> >> >+config BCMAI_HOST_PCI
> >> >+ ? ? ? bool "Support for AI on PCI-host bus"
> >> >+ ? ? ? depends on BCMAI_HOST_PCI_POSSIBLE
> >> >+
> >> >+config BCMAI_DEBUG
> >> >+ ? ? ? bool "BCMAI debugging"
> >> >+ ? ? ? depends on BCMAI
> >> >+ ? ? ? help
> >> >+ ? ? ? ? This turns on additional debugging messages.
> >> >+
> >> >+ ? ? ? ? If unsure, say N
> >
> > Totally useless ?:-(. It should really explain what AI means in this context.
> 
> Feel free to propose sth.

AFAICT AI means "artifical inteligence". So _you_ really need to fix your kconfig.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
