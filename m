From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 12 Dec 2017 15:20:42 +0100
Subject: [PATCH][next] net: phy: meson-gxl: make function
 meson_gxl_read_status static
In-Reply-To: <20171212130311.17185-1-colin.king@canonical.com>
References: <20171212130311.17185-1-colin.king@canonical.com>
Message-ID: <1513088442.26438.18.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-12 at 13:03 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function meson_gxl_read_status is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'meson_gxl_read_status' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Indeed, silly mistake, thx for spotting it.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
