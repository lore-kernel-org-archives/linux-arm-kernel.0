From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 15:25:16 -0600
Subject: [PATCH] dt-bindings: clarify compatible field usage for rockchip
 timers
In-Reply-To: <1480025455-6797-1-git-send-email-al.kochet@gmail.com>
References: <1480025455-6797-1-git-send-email-al.kochet@gmail.com>
Message-ID: <20161130212516.rky3h7io2cmp3eot@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 01:10:55AM +0300, Alexander Kochetkov wrote:
> rk3036 dtsi file already use compatible field as
> "rockchip,rk3036-timer", "rockchip,rk3288-timer".
> 
> The patch clearly shows how that filed should be used on other chips.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  .../bindings/timer/rockchip,rk-timer.txt           |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
