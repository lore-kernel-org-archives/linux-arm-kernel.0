From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 2 Feb 2017 20:01:25 +0200
Subject: [PATCH v3 1/7] soc: smasung: pmu: Add register defines for pad
 retention control
In-Reply-To: <20170130194329.duudcv5oxu2q2td4@kozik-lap>
References: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130123837eucas1p1056a57f23b1e3bf089e5bc55bb2cf2d4@eucas1p1.samsung.com>
 <1485779908-32147-2-git-send-email-m.szyprowski@samsung.com>
 <20170130194329.duudcv5oxu2q2td4@kozik-lap>
Message-ID: <20170202180125.vhastfic3shs3wdl@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 09:43:29PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jan 30, 2017 at 01:38:22PM +0100, Marek Szyprowski wrote:
> > Add PMU defines related to pad retention control. Will be later used
> > by the Exynos pin controller driver.
> > 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> 
> Thanks Marek.
>

I applied this one (with fix of typo) and I will provide a stable tag
with the header.

Best regards,
Krzysztof
