From: menon.nishanth@gmail.com (Nishanth Menon)
Date: Sun, 05 May 2013 10:04:52 -0500
Subject: [PATCH 0/2] ARM: dts: OMAP36xx/OMAP4460 Fix CPU OPP voltages
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Message-ID: <51867514.9030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony/Benoit,
gentle offline ping for this series?
https://patchwork.kernel.org/patch/2494481/
https://patchwork.kernel.org/patch/2494491/
Regards,
Nishanth Menon
On 04/26/2013 12:39 PM, Nishanth Menon wrote:
> Hi,
> It seems that I have not been paying close attention to
> actual voltage value seen on scope to map it back to verify the validity
> of the voltage value. Even though I did verify[1] that voltage did scale to
> values in DT entries, the values in the case of 3630 and 4460 were lower than
> what the spec voltage was as per opp_data files.
>
> This series is based off Benoit's tree here:
> http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts
>
> Commit ID's in the patches to indicate regressions are from there as well.
> Would be good to have this fix merged to 3.10 dts entries.
> I have cross verified that OMAP3430,3630,4430 and 4460 entries now match that
> of corresponding opp*_data.c
>
> My sincere apologies on the oversight.
>
> Nishanth Menon (2):
>    ARM: dts: OMAP36xx: Fix CPU OPP voltages
>    ARM: dts: OMAP4460: Fix CPU OPP voltages
>
>   arch/arm/boot/dts/omap36xx.dtsi |    6 +++---
>   arch/arm/boot/dts/omap4460.dtsi |    6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> [1] http://marc.info/?l=linux-arm-kernel&m=136580742724210&w=2
> Regards,
> Nishanth Menon
>
