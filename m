From: davem@davemloft.net (David Miller)
Date: Wed, 13 Dec 2017 15:05:11 -0500 (EST)
Subject: [PATCH][next] net: phy: meson-gxl: make function
 meson_gxl_read_status static
In-Reply-To: <20171212130311.17185-1-colin.king@canonical.com>
References: <20171212130311.17185-1-colin.king@canonical.com>
Message-ID: <20171213.150511.1299918610251349853.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 12 Dec 2017 13:03:11 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function meson_gxl_read_status is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'meson_gxl_read_status' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
