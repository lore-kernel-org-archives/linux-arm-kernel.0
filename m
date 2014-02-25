From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 20:28:00 +0100
Subject: [GIT PULL v3] efm32 cleanups for next
In-Reply-To: <20140224093653.GD27579@pengutronix.de>
References: <20140219201950.GC6988@pengutronix.de>
 <CAOesGMh16Jqsczaagr9C2niiwu29kd7e8JrWYRZech9kJ2wVRQ@mail.gmail.com>
 <20140224093653.GD27579@pengutronix.de>
Message-ID: <201402252028.00414.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014, Uwe Kleine-K?nig wrote:
> Just three simple cleanups for efm32 removing two now unused files and a
> superflous select by ARCH_EFM32.
> 
> As these cleanups have dependencies on both v3.14-rc1 and my timex.h cleanup
> (which is based on v3.13-rc1) this pull request also included a merge of my
> cleanup tag which is already in armsoc/next/cleanup.
> 


Pulled into next/cleanup,

Thanks.

FWIW, I have a number of small efm32 bug fixes, most of them related to something
breaking with ARMv7-M in combination with random Kconfig options. I hope to get
around to sending them to you for testing soon.

	Arnd
