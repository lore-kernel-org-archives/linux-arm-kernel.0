From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 23 Oct 2014 15:47:32 -0400 (EDT)
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1410231542320.6969@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Oct 2014, Catalin Marinas wrote:

> On Wed, Oct 22, 2014 at 05:06:23PM +0100, mathieu.poirier at linaro.org wrote:
> > +#if __LINUX_ARM_ARCH__ >= 5
> 
> My old ARMv5 book does not list LDRD/STRD. It looks like they only come
> with ARMv5TE. Are there any processors prior to this supported by the
> kernel?

We still supports ARMv4 targets.

As far as I know, all the ARMv5 targets we support are also TE capable.


Nicolas
