From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 15:45:40 -0500
Subject: [PATCH] nvmem: rockchip-efuse: add support for rk322x-efuse
In-Reply-To: <1494557060-105230-1-git-send-email-finley.xiao@rock-chips.com>
References: <1494557060-105230-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20170515204540.t6lzprzmaybjhjmh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 10:44:20AM +0800, Finley Xiao wrote:
> This adds the necessary data for handling eFuse on the rk322x.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 1 +
>  drivers/nvmem/rockchip-efuse.c                             | 4 ++++
>  2 files changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
