From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 13:22:54 -0800
Subject: [PATCH V2 00/14] ARM: OMAP: DMTIMER fixes
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121107212254.GK6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121107 11:03]:
> This series includes several fixes for the OMAP DMTIMER driver. This is
> based upon 3.7-rc4 with the two series adding device-tree support for
> DMTIMERs [1] and the 32kHz Counter [2]

These look OK to me, I'm assuming you'll do a pull request eventually
for these. Might be worth checking if these merge fine also on
omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3, rename detection
might be able to deal with that for the header.

Regards,

Tony


> [1] http://marc.info/?l=linux-omap&m=135065875808614&w=2
> [2] http://marc.info/?l=linux-omap&m=135119308123513&w=2
