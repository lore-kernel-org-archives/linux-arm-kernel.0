From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2018 23:24:19 -0700
Subject: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
In-Reply-To: <20180702202143.25343-1-robertcnelson@gmail.com>
References: <20180702202143.25343-1-robertcnelson@gmail.com>
Message-ID: <20180703062419.GB112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [180702 20:24]:
> Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
> settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
> header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
> Protect.

Thanks applying into omap-for-v4.18/fixes. I'll also add a Fixes tag for
it.

Regards,

Tony
