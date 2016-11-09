From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2016 14:38:06 -0700
Subject: [PATCH v2 0/8] Support TPS65217 PMIC interrupt in DT
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Message-ID: <20161109213805.GB2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Milo Kim <woogyom.kim@gmail.com> [161028 05:38]:
> TPS65217 interrupt events include push button pressed/released, USB and AC 
> voltage status change. AM335x bone based boards (like BB, BBB, BBG) have 
> common PMIC interrupt pin (named NMI) of AM335x core.
> 
> This patchset support interrupts in device tree file.

Applying into omap-for-v4.10/dt except the last patch I'll apply into
omap-for-v4.10/fixes-not-urgent.

Regards,

Tony
