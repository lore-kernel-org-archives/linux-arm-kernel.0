From: dianders@chromium.org (Doug Anderson)
Date: Thu, 1 Sep 2016 20:54:24 -0700
Subject: [PATCH v5 1/4] nvmem: rockchip-efuse: update compatible strings
 for Rockchip efuse
In-Reply-To: <1472786217-52214-2-git-send-email-finley.xiao@rock-chips.com>
References: <1472786217-52214-1-git-send-email-finley.xiao@rock-chips.com>
 <1472786217-52214-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <CAD=FV=UTUAhHQd2pvS+zeRcyPe9XPD4YGjVLy2FRp2uR03NvDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 8:16 PM, Finley Xiao <finley.xiao@rock-chips.com> wrote:
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
