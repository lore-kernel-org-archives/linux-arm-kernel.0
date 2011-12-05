From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Dec 2011 17:08:12 -0500 (EST)
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <4EDD3E5E.6050106@gmail.com>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
 <4EDD3E5E.6050106@gmail.com>
Message-ID: <alpine.LFD.2.02.1112051707520.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2011, Rob Herring wrote:

> On 12/05/2011 03:22 PM, Linus Walleij wrote:
> > Hi Nico,
> > 
> > now I'm lost, I discussed by boot problems on ARM PB1176
> > with Marc and after some investigation I found this strange thing on
> > the lastest rc:s since -rc1:
> > 
> > In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
> > disabled like so:
> > 
> > depends on !ARCH_REALVIEW || !SPARSEMEM
> 
> should be !ARCH_REALVIEW && !SPARSEMEM ?

Indeed.


Nicolas
