From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Dec 2017 07:18:40 -0800
Subject: [PATCH 1/3] ARM: dts: am335x-boneblue: fix wl1835 IRQ pin
In-Reply-To: <20171219223242.21386-1-robertcnelson@gmail.com>
References: <20171219223242.21386-1-robertcnelson@gmail.com>
Message-ID: <20171221151840.GS3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [171219 14:35]:
> Use the correct IRQ gpio pin on the BeagleBone Blue to allow the
> wl1835 wireless module to actually work.

Thanks applying all three into omap-for-v4.16/dt.

Tony
