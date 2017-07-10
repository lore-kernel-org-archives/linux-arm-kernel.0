From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 20:26:03 -0500
Subject: [PATCH 1/2] nvmem: rockchip-efuse: parse 'rockchip,efuse-size'
In-Reply-To: <1499326597-10821-2-git-send-email-finley.xiao@rock-chips.com>
References: <1499326597-10821-1-git-send-email-finley.xiao@rock-chips.com>
 <1499326597-10821-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20170710012603.yf3onf5kp6wgi3b3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 03:36:36PM +0800, Finley Xiao wrote:
> The eFuse size is defined in property <reg> before, but the length
> of registers is not equal to the size on some platforms, so we
> add a new property to redefine it.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 4 ++++
>  drivers/nvmem/rockchip-efuse.c                             | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
