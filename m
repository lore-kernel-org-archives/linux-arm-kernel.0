From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 20:26:42 -0500
Subject: [PATCH 2/2] nvmem: rockchip-efuse: add support for rk3328-efuse
In-Reply-To: <1499326597-10821-3-git-send-email-finley.xiao@rock-chips.com>
References: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
 <1499326597-10821-3-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20170710012642.vg6to37lfqi4cyec@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 03:36:37PM +0800, Finley Xiao wrote:
> This adds the necessary data for handling eFuse on the rk3328.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/nvmem/rockchip-efuse.c                     | 66 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
