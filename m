From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 16 Nov 2016 14:39:17 +0530
Subject: [PATCH v2 2/3] ARM: davinci: PM: cleanup: remove references to
 pdata
In-Reply-To: <20161115195421.19983-3-khilman@baylibre.com>
References: <20161115195421.19983-1-khilman@baylibre.com>
 <20161115195421.19983-3-khilman@baylibre.com>
Message-ID: <b0066bd3-a4e2-36dc-cabb-1ac21bbe9e84@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2016 01:24 AM, Kevin Hilman wrote:
> Since the PM core code is no longer using a fake platform_device or
> platform_data, remove references to 'pdata'.
> 
> No functional changes.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Applied to v4.10/cleanup

Thanks,
Sekhar
