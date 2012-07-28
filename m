From: will.deacon@arm.com (Will Deacon)
Date: Sat, 28 Jul 2012 15:41:40 +0100
Subject: [PATCHv2 3/3] ARM: EXYNOS: Enable PMUs for exynos4/5
In-Reply-To: <01c601cd6c79$30f508e0$92df1aa0$@samsung.com>
References: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
 <1343376509-5881-4-git-send-email-chanho61.park@samsung.com>
 <20120727090201.GD559@mudshark.cambridge.arm.com>
 <01c601cd6c79$30f508e0$92df1aa0$@samsung.com>
Message-ID: <20120728144135.GC11713@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 05:26:43AM +0100, Chanho Park wrote:
> > We have devicetree bindings for the PMU -- why can't you use those instead
> > of probing the SoC all the time?
> 
> Exynos4 isn't fully supported the DT yet. Thus, we should support legacy probing.

Ok, but what about Exynos5? You seem to use the legacy probing there too.

Will
