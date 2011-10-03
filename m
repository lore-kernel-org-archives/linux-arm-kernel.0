From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Oct 2011 11:33:16 +0200
Subject: [PATCH] ARM: EXYNOS: Add ARCH_EXYNOS and reorganize
	arch/arm/mach-exynos
In-Reply-To: <CAH9JG2UNwZxDTPnwjohxhCumKZx_mWcPUn2rROjmjmROoxF07w@mail.gmail.com>
References: <001f01cc80e5$3abd1c80$b0375580$%kim@samsung.com>
	<CAH9JG2UNwZxDTPnwjohxhCumKZx_mWcPUn2rROjmjmROoxF07w@mail.gmail.com>
Message-ID: <5785830.Sj7W4aL3qy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 13:02:16 Kyungmin Park wrote:
> I'm afraid to change machine directory name again. mach-s5pv310 ->
> mach-exynos4 -> mach-exynos.
> As I remember linus blamed the renaming the file names are happened
> frequently at ARM

I tend to agree with this. While the new name does make more sense,
I would first like to see the bigger plan. If you are eventually
planning to consolidate all of mach-s5p64x0, mach-s5pc100, mach-s5pv210,
mach-exynos4 and plat-s5p into one common mach-s5p or mach-exynos
directory, I'm all for that because it reduces code duplication
and work required for the overall cross-subarchitecture single zimage
work.

Simply renaming something because the name does not quite fit entirely
should be done very carefully.

	Arnd
