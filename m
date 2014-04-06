From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 06 Apr 2014 19:28:35 +0200
Subject: Kconfig ARM_ERRATA_753970?
In-Reply-To: <53418889.2050002@free-electrons.com>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com>
Message-ID: <1396805315.7723.8.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-04-06 at 19:02 +0200, Gregory CLEMENT wrote:
> Yes it is correct. ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970
> in kernel 3.2. 

Thanks! That was commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up
Kconfig options for PL310 errata workarounds"), by the way. I hadn't
checked the history of the tree. Had I bothered to do so this all would
have been less mysterious.

> I had just carry on the symbol name without noticed that
> it have changed.
> 
> Do you want to send a fix, or do you prefer I take care of it?

It is a trivial fix, but it might need some testing, which I can't do.
So I guess it's easiest if you take care of it.


Paul Bolle
