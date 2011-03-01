From: khilman@ti.com (Kevin Hilman)
Date: Tue, 01 Mar 2011 12:58:20 -0800
Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
	OMAP2xxx
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain> (Paul
	Walmsley's message of "Tue, 15 Feb 2011 23:52:39 -0700")
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Message-ID: <871v2qk177.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hello,
>
> This patch series adds clock framework-controlled autoidle support for
> the OMAP2xxx DPLL, APLLs, and OMAP2/3 interface clocks.  The old
> direct register writes in the PM code to enable clock autoidle have been
> removed.  
>
> This series also ensures that all clock autoidle is disabled during
> boot and only re-enabled if CONFIG_PM is enabled.
>
> The series applies on the 'clk_autoidle_a_2.6.39' branch of
> git://git.pwsan.com/linux-2.6.
>
> Boot-tested on N800, and dynamic idle-tested on OMAP3430 Beagleboard.
> Compile-tested with omap1_defconfig, omap2plus_defconfig, a 5912
> OSK-only config, an N8x0-only config, an OMAP3-only config, and an OMAP4-only
> config.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Feel free to merge the various pm*.c changes via your tree.

Kevin
