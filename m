From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Jun 2011 14:08:17 +0100
Subject: [PATCH] Disable -fconserve-stack on ARM
In-Reply-To: <20110531180107.GA9261@alboin.amr.corp.intel.com>
References: <1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
	<20110526215101.GL24876@n2100.arm.linux.org.uk>
	<20110527083806.GA21100@e102109-lin.cambridge.arm.com>
	<20110527085414.GP24876@n2100.arm.linux.org.uk>
	<20110527095111.GC21100@e102109-lin.cambridge.arm.com>
	<yw1xlixse2fl.fsf@unicorn.mansr.com>
	<20110528153417.GB25869@alboin.amr.corp.intel.com>
	<20110531163026.GB771@e102109-lin.cambridge.arm.com>
	<20110531180107.GA9261@alboin.amr.corp.intel.com>
Message-ID: <20110602130816.GB8343@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 07:01:07PM +0100, Andi Kleen wrote:
> Disable -fconserve-stack on ARM v2
> 
> There are reports that -fconserve-stack misaligns variables on the stack.
> Disable it for ARM to work around this gcc bug.
> 
> v2: Move top level flags definition up
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

It seems to disable the -fconserve-stack on ARM.

Tested-by: Catalin Marinas <catalin.marinas@arm.com>
