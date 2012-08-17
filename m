From: stigge@antcom.de (Roland Stigge)
Date: Fri, 17 Aug 2012 13:45:31 +0200
Subject: [PATCH] ARM: LPC32xx: Provide DMA filter callbacks via platform
 data
In-Reply-To: <201208171140.50388.arnd@arndb.de>
References: <1345122935-22115-1-git-send-email-stigge@antcom.de>
 <1345201311.27859.51.camel@sauron.fi.intel.com>
 <1345201835.27859.52.camel@sauron.fi.intel.com>
 <201208171140.50388.arnd@arndb.de>
Message-ID: <502E2EDB.2050200@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2012 01:40 PM, Arnd Bergmann wrote:
>> Actually the mtd patches do not compile-depend on it, sorry, I am
>> dropping it from the MTD tree. Thanks!
> 
> For reference, I'm fine with either outcome, I don't mind seeing an
> occasional collision with subsystem trees, as they tend to be trivial
> to resolve.
> 
> If you split a series to go through multiple git trees, you have to
> ensure that both halves are actually regression free by themselves,

Of course. But in this very case, they are. So I'd prefer pushing them
via different trees because I have other patches for mach-lpc32xx in the
queue and would like to minimize work for you. :-)

Roland
