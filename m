From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Oct 2014 10:23:09 +0100
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <alpine.LFD.2.11.1410231542320.6969@knanqh.ubzr>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1410231542320.6969@knanqh.ubzr>
Message-ID: <20141024092309.GC20534@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 08:47:32PM +0100, Nicolas Pitre wrote:
> On Wed, 22 Oct 2014, Catalin Marinas wrote:
> 
> > On Wed, Oct 22, 2014 at 05:06:23PM +0100, mathieu.poirier at linaro.org wrote:
> > > +#if __LINUX_ARM_ARCH__ >= 5
> > 
> > My old ARMv5 book does not list LDRD/STRD. It looks like they only come
> > with ARMv5TE. Are there any processors prior to this supported by the
> > kernel?
> 
> We still supports ARMv4 targets.

Yes. What I meant is non-TE ARMv5 targets.

-- 
Catalin
