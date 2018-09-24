From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 24 Sep 2018 21:08:04 +0200
Subject: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Message-ID: <b87baa02-66e7-b855-478a-6d0bb4d39bad@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
