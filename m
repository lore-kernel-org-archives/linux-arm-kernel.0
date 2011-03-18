From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 18 Mar 2011 15:39:45 +0000
Subject: [PATCHv6 0/5] ARM: add initial support for Picochip picoXcell SoC
In-Reply-To: <1299596817-19879-1-git-send-email-jamie@jamieiles.com>
References: <1299596817-19879-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110318153945.GA3393@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Mar 08, 2011 at 03:06:52PM +0000, Jamie Iles wrote:
> I've respun this patch series to move the DEBUG_LL 32-bit helpers into
> debug-macro.S like mach-davinci does and include the basic clk stuff so
> that we can build with drivers that want CLK support.
> 
> This patch series takes us to a login console over serial on both PC3X2
> and PC3X3 devices on the PC7302 board booted with NOR flash.  I plan on
> adding support for the next generation of soc, PM, cpufreq etc at a
> later date once these patches are merged but figured it would be good to
> start with a nice stable base.
> 
> Any feedback would be very much appreciated!
> 
> Thanks,
> 
> Jamie Iles (5):
> 
>   picoxcell: support for Picochip picoXcell SoC
>   picoxcell: support for the common system timers
>   picoxcell: common SoC peripheral support
>   picoxcell: basic clk infrastructure
>   picoxcell: support for the PC7302 development board

I was wondering if there was anything I could do to help move this 
series along a bit.  Whilst I haven't had much direct feedback to these 
patches I have tried to take on board any feedback to other machine 
patches where relevant.

How about adding a tree to linux-next?

Jamie
