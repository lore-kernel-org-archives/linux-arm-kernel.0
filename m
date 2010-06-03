From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Jun 2010 15:59:03 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100603192459.GA9169@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1006031549400.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jun 2010, Russell King - ARM Linux wrote:

> The subject says everything you need to know.  Randy provided this
> link earlier:
> 
>   http://lkml.org/lkml/2010/6/2/472

Leaving the drama aside...

I agree that there is indeed a growing problem with the growing number 
of ever growing defconfigs.

And the problem is made even worse by the diversity, and shall we say 
"success" of the ARM architecture.

The average defconfig file for a new target is going to be _larger_ than 
the size of the actual source code for that target if the trend 
continues.

Let's acknowledge the problem and try to come up with a solution.


Nicolas
