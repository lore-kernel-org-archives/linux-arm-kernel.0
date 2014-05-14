From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 14:43:08 -0700
Subject: [PATCHv2 3/5] arm: omap2: skip device build from platform code
 for dt.
In-Reply-To: <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
 <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
Message-ID: <20140514214308.GI27426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sourav Poddar <sourav.poddar@ti.com> [140507 23:01]:
> For SOCs with dt enabled, device should be build through device tree.
> Prevent device build call from platform code, if device tree is
> enabled.

Picking this patch into omap-for-v3.16/dt thanks.

Tony
