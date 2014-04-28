From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 28 Apr 2014 18:28:45 +0000 (UTC)
Subject: [PATCH 3/5] arm: omap2: skip device build from platform code
 for dt.
In-Reply-To: <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
 <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
Message-ID: <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Sourav Poddar wrote:

> For SOCs with dt enabled, device should be build through device tree.
> Prevent device build call from platform code, if device tree is
> enabled.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Isn't OMAP2+ only supporting DT device enumeration now?


- Paul
