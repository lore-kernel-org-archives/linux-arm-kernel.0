From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 10:36:28 +0100
Subject: [PATCH v5 3/5] ARM: EXYNOS: Enable PMUs for exynos4
In-Reply-To: <007301cdb32f$26eb92e0$74c2b8a0$@samsung.com>
References: <1351056894-5790-1-git-send-email-chanho61.park@samsung.com>
 <1351056894-5790-4-git-send-email-chanho61.park@samsung.com>
 <CAOesGMg5Nn5i=J8o3Rt8es3Tq_LZgVttuYSBbvYfmw1QTGwx0A@mail.gmail.com>
 <005801cdb251$e52f7480$af8e5d80$@samsung.com>
 <20121025144125.GH11267@mudshark.cambridge.arm.com>
 <007301cdb32f$26eb92e0$74c2b8a0$@samsung.com>
Message-ID: <20121026093628.GE20914@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 05:05:36AM +0100, Chanho Park wrote:
> > 
> > I agree that we definitely want to support the PMU on Exynos4, but I'm
> > tempted to postpone adding that code until DT support is available.
> 
> I already included DT support for exynos4(except exynos4412) in this patchset.
> (Please see the [PATCH v5 5/5] ARM: EXYNOS: Add arm-pmu DT binding for exynos421x)

The only patch I'm objecting to is the second one, which adds the hardcoded
combiner data. That seems orthogonal to the DT patches, which look fine to
me.

Will
