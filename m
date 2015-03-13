From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 16:36:06 +0100
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <20150313152843.GP8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <2439386.JhP59gsGzr@wuerfel> <20150313152843.GP8656@n2100.arm.linux.org.uk>
Message-ID: <62638459.PRFbbMQpY2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 15:28:43 Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 04:08:31PM +0100, Arnd Bergmann wrote:
> > I think the easiest and cleanest way would be to let that case not
> > happen. Adding the reset controller core makes the kernel about 2kb
> > larger, but in most multiplatform configurations, you get it already.
> 
> Well, I personally hate selecting visible Kconfig symbols.  It's
> against my religion.
> 

I know what you mean. I already created a patch for this:
 
https://lkml.org/lkml/2015/2/24/317

Need to dig that out again and address the comments I got.

	Arnd
