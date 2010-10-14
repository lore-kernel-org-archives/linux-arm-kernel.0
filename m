From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 14:41:24 +0900
Subject: [PATCH V2 1/2] ARM: S5P: Add initial map for GPIO2 and GPIO3
In-Reply-To: <AANLkTimKNBfDpz_3E4z6MHV7V1Ht9Yobf6qbGMxyWWAy@mail.gmail.com>
References: <1286868876-3748-1-git-send-email-sbkim73@samsung.com>
	<1286868876-3748-2-git-send-email-sbkim73@samsung.com>
	<006601cb6b60$0a0e4190$1e2ac4b0$%kim@samsung.com>
	<AANLkTimKNBfDpz_3E4z6MHV7V1Ht9Yobf6qbGMxyWWAy@mail.gmail.com>
Message-ID: <006901cb6b62$72766580$57633080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Thu, Oct 14, 2010 at 2:24 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Sangbeom Kim wrote:
> >>
> >> From: Jongpill Lee <boyko.lee@samsung.com>
> >>
> >> This patch adds initial map for GPIO2 and GPIO3.
> >> S5PV310/S5PC210 has separated GPIO1, GPIO2 and GPIO3.
> >>
> >> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> >> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> >> ---
> >> Changes since v1:
> >> - Rebased on latest for-next from Kukjin Kim's git tree
> >> - Added S5P_VA_GPIO1 according to S5PV310_PA_GPIO1
> >>
> >> ?arch/arm/mach-s5pv310/cpu.c ? ? ? ? ? ? ?| ? 12 +++++++++++-
> >> ?arch/arm/plat-s5p/include/plat/map-s5p.h | ? ?3 +++
> >> ?2 files changed, 14 insertions(+), 1 deletions(-)

(snip)

> >> + ? ? ? ? ? ? .virtual ? ? ? ?= (unsigned long)S5P_VA_GPIO3,
> >> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(S5PV310_PA_GPIO3),
> >> + ? ? ? ? ? ? .length ? ? ? ? = SZ_256K,
> Why 256K?

Oh...yeah, it's typo :-(
Maybe 256?...

Hmm...I will change it when merge.

Thanks for your pointing out.

(snip)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
