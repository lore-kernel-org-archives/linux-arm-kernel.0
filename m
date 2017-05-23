From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 09:08:48 -0500
Subject: [PATCH v2 2/3] dt-bindings: add bindings for rk3128 clock
 controller
In-Reply-To: <1495073819-4160-3-git-send-email-zhangqing@rock-chips.com>
References: <1495073819-4160-1-git-send-email-zhangqing@rock-chips.com>
 <1495073819-4160-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20170523140848.7a3auouimenz5ii2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 10:16:58AM +0800, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3128-cru.txt         | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3128-cru.txt

This and patch 1 can be combined, but don't have to be. For both:

Acked-by: Rob Herring <robh@kernel.org>
