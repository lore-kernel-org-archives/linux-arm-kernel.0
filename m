From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 25 Oct 2011 11:56:40 +0530
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4EA65073.7050205@ti.com>
References: <4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<4EA13053.7080306@ti.com>
	<20111021115809.GB337@S2100-06.ap.freescale.net>
	<4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<20111024090228.GA1755@S2100-06.ap.freescale.net>
	<4EA52851.8000203@ti.com>
	<20111024091158.GB1755@S2100-06.ap.freescale.net>
	<4EA52C56.3080908@ti.com>
	<20111024134727.GF1755@S2100-06.ap.freescale.net>
	<4EA65073.7050205@ti.com>
Message-ID: <4EA656A0.4010102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2011 11:30 AM, Rajendra Nayak wrote:
>
> In that case should you not be first converting the mfd driver to
> register regulator devices using DT?
> Thats what we did for OMAP, and hence we always have the of_node
> populated when the regulator devices are probed.
> See this patch from Benoit on how thats done for twl devices..
> http://marc.info/?l=linux-omap&m=131489864814428&w=2

Sorry, that was a link to an older version of the patch.
Here's the latest one from Benoit which he did based
on Arnd's suggestion of using of_platform_populate() directly.

http://marc.info/?l=linux-omap&m=131705623822369&w=2
