From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 23 Jun 2014 10:14:37 +0900
Subject: [PATCH] ARM: exynos: Fix warning by constifying 'reg' in
 exynos_fdt_map_chipid()
In-Reply-To: <CAK5sBcEcvXKFypDAx2E+fGZHk-VLhfbxU4QydvQTs2nTjb47pQ@mail.gmail.com>
References: <3c6b5c1f19fcbee39a3f0a0bd2c9ddd811d5e619.1402547301.git.viresh.kumar@linaro.org>
 <CAKohponQhitVO2zX0+=5bU76vC=+ofpqZo1F5CxyUDDD24prhw@mail.gmail.com>
 <CAK5sBcEcvXKFypDAx2E+fGZHk-VLhfbxU4QydvQTs2nTjb47pQ@mail.gmail.com>
Message-ID: <026201cf8e80$8059f190$810dd4b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Hi Viresh,
> 
> On Thu, Jun 12, 2014 at 10:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Fix Sachin's id, looks like he left Linaro ..
> >
> > On 12 June 2014 10:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> exynos_fdt_map_chipid() was recently added with: cbf08b9 (ARM: EXYNOS:
> >> Consolidate exynos4 and exynos5 machine files) and generates this warning:
> >>
> >> arch/arm/mach-exynos/exynos.c: In function ?exynos_fdt_map_chipid?:
> >> arch/arm/mach-exynos/exynos.c:208:6: warning: assignment discards ?const? qualifier
> from pointer target type [enabled by default]
> >>
> >> Constify 'reg' to fix it.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I have already posted a patch [1] to fix this.
> Kukjin, can you please queue this up.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg328216.html

+ Arnd

If I remember correctly, it should be queued by Arnd?

Arnd, do you want me to take it?

- Kukjin
