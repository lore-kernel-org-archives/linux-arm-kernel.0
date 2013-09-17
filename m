From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 Sep 2013 12:55:57 -0400
Subject: [PATCH] ARM: dts: DRA7: provide arch-timer frequenecy parameter
In-Reply-To: <1379436433-24914-1-git-send-email-nm@ti.com>
References: <1379436433-24914-1-git-send-email-nm@ti.com>
Message-ID: <5238899D.60903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 September 2013 12:47 PM, Nishanth Menon wrote:
> CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
> same. Without a valid value arch_timer_init results in div0 crash.
s/same/timer frequency via DT
> Providing the same is a safer alternative.
Above statement won't be necessary. 

> Cc: R Sricharan <r.sricharan@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
Apart from minor change log fix,

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
