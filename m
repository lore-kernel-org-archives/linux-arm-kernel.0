From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 3 Jul 2010 22:48:04 +0300
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <20100703194803.GA29907@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Fri, Jul 02, 2010 at 08:02:57PM +0200, Robert Schwebel wrote:
> We have recently made some benchmarks, in order to get a little bit
> better fealing about where ARM cpus are today, especially when it comes
> to the "recent" ones, and in comparism to the Atom. So we collected a
> few benchmarks (most from lmbench) and did some actual measurements.
> 
> Here is a little article:
> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html

The ARM architecture version in the list of tested hardware is wrong for the 
ARM1136 and Cortex-A8 cores. Should be ARMv6 and ARMv7, respectively.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
