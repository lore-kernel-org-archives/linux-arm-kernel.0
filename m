From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 11 Aug 2016 09:40:29 -0700
Subject: [PATCHES] ARM: dts: update udoo and evi hubs to use pwrseq
In-Reply-To: <20160810030254.GD1879@shlinux2>
References: <20160810030254.GD1879@shlinux2>
Message-ID: <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Peter,

Consider this my attempt to squeeze my own dts into your patch series.
These patches repalce patch 6 in V5. of the usb pwrseq series
I adding a #address and #size to imx6qdl.dtsi in patch 1
and remove those lines from imx6qdl-udoo.dtsi in patch 2 (formerly patch 6)
Finally I make the change in imx6q-evi.dts and hope is can be slipped into
the series with the others.

Thanks, Joshua
