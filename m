From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 25 May 2010 11:19:37 +0300
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100525081937.GA11783@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 05, 2010 at 08:54:12AM +0200, Westerberg Mika.1 (EXT-Nixu/Helsinki) wrote:
> 
> This is re-send of the series. I didn't receive any comments on this but we
> found few minor things during in-house review which are incorporated.
> 
> Changes to v1:
> 	- corrected kernel-doc for crash_setup_regs()
> 	- check return value of ioremap() in copy_oldmem_page()
> 
> Changes to RFC version:
> 	- crash_setup_regs() uses Russell's suggestion for saving registers
> 	- copy_oldmem_page() code is changed to use ioremap()
> 	- there is no need for special 'mem=' parameters
> 
> I've tested this on N900 and beagleboard.

Hi Russell,

Sorry to bother you with this but I wasn't sure what is going to happen with
these patches. Are you planning to take them or do you want me to change
something?

I already submitted these to your patch system as I didn't receive much
comments (not sure was this the right thing to do, however).

In addition, I tested these on ep93xx based Sim.One board and they seem to work
there as well.

Thanks,
MW
