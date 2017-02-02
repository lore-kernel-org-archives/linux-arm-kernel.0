From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Feb 2017 20:38:07 +0200
Subject: [PATCH 0/4] phy/mfd/soc: exynos: Header cleanup
In-Reply-To: <588F039D.3090503@ti.com>
References: <20170127200510.4444-1-krzk@kernel.org> <588F039D.3090503@ti.com>
Message-ID: <20170202183807.tylyvgpk5roecsvs@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 02:43:01PM +0530, Kishon Vijay Abraham I wrote:
> 
> 
> On Saturday 28 January 2017 01:35 AM, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Suggested by Marek, continuation of cleanup of PMU register defines
> > in headers.
> > 
> > Let's keep all of them in include/linux/soc/samsung/exynos-regs-pmu.h.
> > 
> > This is based on:
> > 1. Marek's recent work around pinctrl/power domains/lpass:
> >    https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
> >    branch: v4.10-next-tm2-pd
> > 
> > 2. My two previous patches for cleanup:
> >    https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git
> >    branch: for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends
> > 
> > Affected subsystems/drivers:
> > 1. phy - drivers,
> > 2. mfd - headers,
> > 3. soc/samsung - header.
> > 
> > However because of dependency on Marek's patchset, I do not have a clue
> > how to merge it... it is not an urgent stuff, so it may wait till
> > dependencies get in.
> 
> I'll defer merging this.

Okay, the compile dependency went to my tree and is available under
samsung-drivers-soc-pmu-4.11-3 tag (see below). However the patches
probably won't apply cleanly so if you wish, I can rebase them.

Also they miss an ack from Lee Jones.

Best regards,
Krzysztof


The following changes since commit ee55ae6194a5439bde3a3b8ee0abda63c610e740:

  soc: samsung: pmu: Remove duplicated define for ARM_L2_OPTION register (2017-01-27 11:32:31 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-soc-pmu-4.11-3

for you to fetch changes up to b343d77b94b6702082f4f402e1492e71ef87095b:

  soc: samsung: pmu: Add register defines for pad retention control (2017-02-02 20:00:28 +0200)

----------------------------------------------------------------
3rd round of improvements for Exynos PMU driver for v4.11:
1. Add defines in header for future patches changing the pad
   retention control.

----------------------------------------------------------------
Marek Szyprowski (1):
      soc: samsung: pmu: Add register defines for pad retention control
