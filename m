From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Apr 2011 12:03:03 +0100
Subject: Common clock and dvfs
In-Reply-To: <BANLkTikhAiujU=Fmpvp-hWAeoTBNXZoEEA@mail.gmail.com>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<20110422194027.GB4768@sirena.org.uk>
	<BANLkTin9mbGKAMB4Bgd=5th+6FgS9gMCtA@mail.gmail.com>
	<20110422203526.GC4768@sirena.org.uk>
	<BANLkTikhAiujU=Fmpvp-hWAeoTBNXZoEEA@mail.gmail.com>
Message-ID: <20110425110303.GB30859@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 02:18:06PM -0700, Colin Cross wrote:

> I see.  Do you happen to know if there are any max voltage
> requirements for clocks?  Would running one clock in a group at a low
> operating point and another at a high operating point cause a problem,
> assuming the voltage is set to what is required by the high operating
> point?

I'm not aware of any such requirements, and my understanding of the
electrical engineering issues suggests that they'd be unlikely.
