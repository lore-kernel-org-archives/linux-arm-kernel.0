From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 30 Jun 2011 14:14:28 +0900
Subject: [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
In-Reply-To: <1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
	<1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
Message-ID: <BANLkTi=nQEe_JaoBvi6iPSDpR7F4QMsi9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 4:34 PM, Changhwan Youn <chaos.youn@samsung.com> wrote:
> This patch adds external GIC io memory mapping
> to support external GIC on EXYNOS4.
>
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> ---
> ?arch/arm/mach-exynos4/cpu.c ? ? ? ? ? ? ?| ? 10 ++++++++++
> ?arch/arm/mach-exynos4/include/mach/map.h | ? ?5 +++--
> ?arch/arm/plat-s5p/include/plat/map-s5p.h | ? ?5 +++--
> ?3 files changed, 16 insertions(+), 4 deletions(-)
>

Hello,

It appears that something is missing in the patch series.
A patch related with "AUDSS" is required before applying this patch.
I get patch fail errors at cpu.c and map-s5p.h.


Cheers!

- MyungJoo

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
