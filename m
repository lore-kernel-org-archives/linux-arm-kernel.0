From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2016 11:18:48 -0800
Subject: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
In-Reply-To: <1456439796-28546-6-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-6-git-send-email-fcooper@ti.com>
Message-ID: <20160226191848.GJ13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
> From: Vignesh R <vigneshr@ti.com>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.

Are the dts changes safe to pick separately? I'm mostly worried
about clock related hangs unless the clock changes are merged
first.

Regards,

Tony
