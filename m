From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Feb 2012 15:02:04 -0800
Subject: [PATCH 4/7] OMAP4: twl-common: Add twl6030 V1V8, V2V1 SMPS
 common configuration
In-Reply-To: <1328868316-24749-5-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120222230204.GR18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120210 01:34]:
> V1V8 supply from twl6030 commonly used as VIO for the machine.
> V2V1 is adviced to supply the twl6040, and also to feed the twl6030's
> VCXIO_IN, and VDAC_IN inputs.
> Create the common regulator configurations for these regulators:
> Make the V2V1 as supply_regulator for VCXIO, VDAC.
> Add twl6040 (1-004b) as consumer for V1V8, and V2V1.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
