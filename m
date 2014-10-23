From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Oct 2014 20:51:19 +0100
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <alpine.LFD.2.11.1410231542320.6969@knanqh.ubzr>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022164454.GI15370@e104818-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1410231542320.6969@knanqh.ubzr>
Message-ID: <20141023195119.GL27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 03:47:32PM -0400, Nicolas Pitre wrote:
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
> 
> As far as I know, all the ARMv5 targets we support are also TE capable.

Not quite.  We have ARM1020, which according to our proc-*.S files is
only ARMv5T, not ARMv5TE.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
