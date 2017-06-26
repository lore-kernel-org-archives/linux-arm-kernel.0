From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:39:00 -0500
Subject: [PATCH] nvmem: rockchip-efuse: amend compatible rk322x-efuse to
 rk3228-efuse
In-Reply-To: <1498121207-24941-1-git-send-email-frank.wang@rock-chips.com>
References: <1498121207-24941-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <20170626183900.iz2pey7fyz3xvc3q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 04:46:47PM +0800, Frank Wang wrote:
> As the comments from Heiko Stuebner <heiko@sntech.de> that compatible
> should not contain any placeholders, this patch fix it for rk3228 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 2 +-
>  drivers/nvmem/rockchip-efuse.c                             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
