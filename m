From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 04:50:05 -0700
Subject: [PATCH] ARM: dts: Fix TI CPSW Phy mode selection on IGEP COM
 AQUILA.
In-Reply-To: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
References: <1403696525-10099-1-git-send-email-eballetbo@iseebcn.com>
Message-ID: <20140707115004.GU28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <eballetbo@iseebcn.com> [140625 04:44]:
> As this board use external clock for RMII interface we should specify 'rmii'
> phy mode and 'rmii-clock-ext' to make ethernet working.

Thanks applying into omap-for-v3.16/fixes.

Tony
