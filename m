From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 09:16:31 -0500
Subject: [PATCH v4 1/3] nvmem: rockchip-efuse: update compatible strings
 for Rockchip efuse
In-Reply-To: <1472464210-30252-2-git-send-email-finley.xiao@rock-chips.com>
References: <1472464210-30252-1-git-send-email-finley.xiao@rock-chips.com>
 <1472464210-30252-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20160902141631.GA23238@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:50:08AM -0700, Finley Xiao wrote:
> Rk3399-efuse is organized as 32bits by 32 one-time programmable electrical
> fuses. The efuse of earlier SoCs are organized as 32bits by 8 one-time
> programmable electrical fuses with random access interface.
> 
> Add different device tree compatible string for different SoCs to be able
> to differentiate between the two. The old binding is of course preserved,
> though deprecated.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
