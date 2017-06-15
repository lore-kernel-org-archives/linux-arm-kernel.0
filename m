From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 15 Jun 2017 19:47:40 +0530
Subject: [PATCH v2 1/2] ARM: davinci: pdata-quirks: fix const warnings
In-Reply-To: <20170609172111.23057-2-khilman@baylibre.com>
References: <20170609172111.23057-1-khilman@baylibre.com>
 <20170609172111.23057-2-khilman@baylibre.com>
Message-ID: <8ec3edc0-3391-6c63-ecf3-0841a111758f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 June 2017 10:51 PM, Kevin Hilman wrote:
> After VPIF was converted to enable getting subdevs from DT, the
> pdata is no longer const, so remove these to avoid compiler warnings.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Applied to v4.13/soc. I dropped the "pdata-quirks" prefix in subject
line since the patch is fixing more that that.

Thanks,
Sekhar
