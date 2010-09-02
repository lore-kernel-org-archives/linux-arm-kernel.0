From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 02 Sep 2010 18:43:02 +0300
Subject: Colibri PXA320 Power management question
In-Reply-To: <20100902152705.GC5809@rakim.wolfsonmicro.main>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
	<20100902142203.GA8381@sirena.org.uk>
	<4C7FB7B5.2010301@compulab.co.il>
	<20100902152705.GC5809@rakim.wolfsonmicro.main>
Message-ID: <4C7FC606.20904@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Thu, Sep 02, 2010 at 05:41:57PM +0300, Mike Rapoport wrote:
>> Mark Brown wrote:
> 
>>> The expectation in Linux is that voltage scaling will be done in
>>> software using cpufreq rather than autonomously by the CPU.
> 
>> PXA3xx has ability to automatically control certain regulators
>> (almost) without software intervention. Setting the bits Yuri is
>> talking about should enable CPU initiated i2c transactions upon
>> frequency scaling events.
> 
> Yes, exactly - what I'm saying is that Linux is set up to use cpufreq
> rather than rely on the built in stuff.

There's no contradiction here. The PXA3XX cpufreq implementation could trigger 
automatic voltage scaling.

-- 
Sincerely yours,
Mike.
