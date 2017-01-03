From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 14:41:21 -0600
Subject: [PATCH v5 2/4] dt-bindings: add bindings for rk3328 clock
 controller
In-Reply-To: <1482979511-6847-3-git-send-email-zhangqing@rock-chips.com>
References: <1482979511-6847-1-git-send-email-zhangqing@rock-chips.com>
 <1482979511-6847-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20170103204121.cmbtttx5oogfmm5y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 10:45:09AM +0800, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Changes in v4:
>   dropping the "rockchip,cru" and "syscon" properties for bindings of rk3328
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3328-cru.txt         | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt

Acked-by: Rob Herring <robh@kernel.org>
