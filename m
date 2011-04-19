From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 19 Apr 2011 16:04:55 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104191655.13133.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191616.01647.arnd@arndb.de>
	<20110419145009.GH9462@sirena.org.uk>
	<201104191655.13133.arnd@arndb.de>
Message-ID: <20110419150455.GI1765@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 04:55:12PM +0200, Arnd Bergmann wrote:

> I was thinking of arch/arm/mach-ux500/regulator-db8500.c in linux-next.

> I can only see regulator contents in there, what do you mean by
> system management?

All the fiddling around with the PRCMU and the power state faff (which
on closer look now seems to be only in this file, hrm).
