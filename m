From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2012 01:15:38 -0700
Subject: [PATCH 1/2] ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
In-Reply-To: <1339592110-14312-2-git-send-email-lifshitz@compulab.co.il>
References: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
 <1339592110-14312-2-git-send-email-lifshitz@compulab.co.il>
Message-ID: <20120702081537.GE1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Lifshitz <lifshitz@compulab.co.il> [120613 06:00]:
> Setup pinmux for CPI and register the mt9t001 camera sensor
> in ISP subsystem.

Applying both into devel-board branch. Note that we are phasing
out the board-*.c files with device tree support, so only minimal
changes will be applied to the board-*.c files at this point.

Regards,

Tony
