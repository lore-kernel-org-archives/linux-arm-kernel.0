From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Nov 2015 11:03:04 -0800
Subject: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
In-Reply-To: <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
Message-ID: <20151106190304.GB3218@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@kernel.org> [151106 10:37]:
> On Fri, Nov 6, 2015 at 8:13 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > This reverts commit af19161aaed7ff8d1a52b2e517460f2fa0774e32,
> > which breaks the omap3 device tree build due to a wrong reference.
> >
> > I accidently queued this change via the power supply subsystem while
> > telling Marek at the same time, that it should go through Tony's tree.
> > Following that I did miss Stephen's messages about the build failure in
> > linux-next and since he switched to merging an older snapshot nobody
> > else noticed the problem in my tree. I didn't notice myself, since I
> > did not build any device tree files assuming none have changed by me.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> 
> We also found this in kernelci.org build testing, and verified that
> this fixes the build.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> Thanks Felipe for reporting, and thanks Sebastian for the quick fix.

Acked-by: Tony Lindgren <tony@atomide.com>

Thanks,

Tony
