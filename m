From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Sep 2010 16:27:05 +0100
Subject: Colibri PXA320 Power management question
In-Reply-To: <4C7FB7B5.2010301@compulab.co.il>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
Message-ID: <20100902152705.GC5809@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 05:41:57PM +0300, Mike Rapoport wrote:
> Mark Brown wrote:

> >The expectation in Linux is that voltage scaling will be done in
> >software using cpufreq rather than autonomously by the CPU.

> PXA3xx has ability to automatically control certain regulators
> (almost) without software intervention. Setting the bits Yuri is
> talking about should enable CPU initiated i2c transactions upon
> frequency scaling events.

Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
rather than rely on the built in stuff.
