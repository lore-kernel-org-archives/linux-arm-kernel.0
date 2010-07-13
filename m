From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Jul 2010 15:17:58 +0900
Subject: [PATCH v2] ARM: s5pv210_defconfig: Update for removing
	s5pc110_defconfig
In-Reply-To: <AANLkTilAKmCrHm5pZU5s6oJkSGGZyYihsnPsG4Z1uKFw@mail.gmail.com>
References: <1278987726-10803-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTilAKmCrHm5pZU5s6oJkSGGZyYihsnPsG4Z1uKFw@mail.gmail.com>
Message-ID: <00fc01cb2253$27307c30$75917490$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Question?
> 
> Are there difference between smdkc110 and smdkv210?

Yes.

The components on the board are different such as default LCD module,
external memory, connector, and so on.

> 
> Thank you,
> Kyungmin Park
> 
> On Tue, Jul 13, 2010 at 11:22 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > Now that S5PC110 machines and S5PV210 machines can be built into
> > one kernel, update mach-s5pv210/Kconfig and s5pv210_defconfig.
> >
> > Tested on SMDKC110(S5PC110) and SMDKV210(S5PV210).
> > Note that GONI machine ID is not included in the kernel.
> >
> > Created and tested against linux-2.6.35-rc5.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > Changes since v1:
> > - This patch re-based against linux-2.6.35-rc5 which includes
> > ?'ARM: reduce defconfigs' from Uwe Kleine-Konig.
> >
> > ?arch/arm/configs/s5pc110_defconfig | ? 66
------------------------------------
> > ?arch/arm/configs/s5pv210_defconfig | ? ?4 ++
> > ?arch/arm/mach-s5pv210/Kconfig ? ? ?| ? 28 +++++++++------
> > ?3 files changed, 21 insertions(+), 77 deletions(-)
> > ?delete mode 100644 arch/arm/configs/s5pc110_defconfig

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
