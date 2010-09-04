From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 4 Sep 2010 04:31:49 +0200
Subject: [Openpxa-users] Colibri PXA320 Power management question
In-Reply-To: <4C7FC606.20904@compulab.co.il>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
	<4C7FC606.20904@compulab.co.il>
Message-ID: <201009040431.49798.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 2. z??? 2010 17:43:02 Mike Rapoport napsal(a):
> Mark Brown wrote:
> > On Thu, Sep 02, 2010 at 05:41:57PM +0300, Mike Rapoport wrote:
> >> Mark Brown wrote:
> >>> The expectation in Linux is that voltage scaling will be done in
> >>> software using cpufreq rather than autonomously by the CPU.
> >> 
> >> PXA3xx has ability to automatically control certain regulators
> >> (almost) without software intervention. Setting the bits Yuri is
> >> talking about should enable CPU initiated i2c transactions upon
> >> frequency scaling events.
> > 
> > Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
> > rather than rely on the built in stuff.
> 
> There's no contradiction here. The PXA3XX cpufreq implementation could
> trigger automatic voltage scaling.

Considering the CPU and the regulator are compatible and you wont fry the CPU. 
In that case, you use cpufreq indeed.
