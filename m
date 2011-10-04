From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Oct 2011 14:49:50 -0400 (EDT)
Subject: Git pull request: mach/vmalloc.h removal,
	and ioremap optimizations
In-Reply-To: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
Message-ID: <alpine.LFD.2.02.1110041444270.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Sep 2011, Nicolas Pitre wrote:

> Russell, please pull
> 
> 	git://git.linaro.org/people/nico/linux vmalloc

Given the problems that exist in the OMAP tree and their likely fixes 
going into mainline only during the next merge window, I'm withdrawing 
this request until the next cycle.

> One regression was discovered on shmobile during testing because that 
> platform asks for 158MB of consistent DMA memory while the documented 
> maximum is 14MB.  Inspection of the code doesn't tell why this is 
> required, and listed maintainers did not respond yet after a couple 
> days.  So a temporary exception to the definition of VMALLOC_END was 
> added for CONFIG_SHMOBILE and a noisy warning to get those maintainers' 
> attention.

For the record, those maintainers still didn't respond.


Nicolas
