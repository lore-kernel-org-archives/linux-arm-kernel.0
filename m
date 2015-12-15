From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 15 Dec 2015 19:21:01 +0530
Subject: [PATCH V2 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC
 TPS65217
In-Reply-To: <1450118580-24754-2-git-send-email-nm@ti.com>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-2-git-send-email-nm@ti.com>
Message-ID: <20151215135100.GA8288@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 14, 2015 at 12:42:58PM -0600, Nishanth Menon wrote:

> Enable PMIC for beaglebone similar to commit 7a5c6065669c ("ARM:
> OMAP2+: omap2plus_defconfig: Add tps65217 support") - this allows
> multi_v7_defconfig to boot up on older beaglebone platforms.

A similar one -

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384289.html

your v1 was earlier than the above, so mine should > /dev/null.

Seems Arnd wants multi_v7_defconfig changes thr' submaintainers rather
than directly (which I initially thought was supposed to be done)

Regards
afzal
