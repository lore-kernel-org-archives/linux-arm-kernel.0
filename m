From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Sep 2010 15:32:31 +0100
Subject: [PATCH 03/24] arm: mm: add proc info for ScorpionMP
In-Reply-To: <1282926826.5075.21.camel@m0nster>
References: <1282922978.5075.13.camel@m0nster>
	<1282925072.26355.61.camel@e102109-lin.cambridge.arm.com>
	<1282926826.5075.21.camel@m0nster>
Message-ID: <20100904143231.GB16462@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 09:33:46AM -0700, Daniel Walker wrote:
> So your saying it makes more sense to change the msm entry into the
> default entry, and make the current default into the
> ARM11MPCore/Cortex-A9 entry?
> 
> There's 4 or 5 other cpu's that have SMP but none have had to jump over
> those bits AFAIK ..

What CPUs (CPU not SoC) are you referring to?

CPUs is the core that runs the code.  SoC is the CPU with the peripherals.
OMAP is not a CPU.  OMAP is a SoC.
