From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Sep 2017 09:32:58 -0500
Subject: [PATCH 3/4] nvmem: rockchip: add support for RK3368
In-Reply-To: <20170828121604.15968-4-romain.perier@collabora.com>
References: <20170828121604.15968-1-romain.perier@collabora.com>
 <20170828121604.15968-4-romain.perier@collabora.com>
Message-ID: <20170901143258.ccto72dhc5hd34ou@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 02:16:03PM +0200, Romain Perier wrote:
> This adds the necessary functions and data for handling support on RK3368
> SoCs.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +

For the binding only:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/nvmem/rockchip-efuse.c                     | 80 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
