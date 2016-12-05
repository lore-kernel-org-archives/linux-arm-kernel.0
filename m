From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Dec 2016 16:22:43 -0600
Subject: [PATCH v4 1/9] dt-bindings: clarify compatible property for
 rockchip timers
In-Reply-To: <1480436092-10728-2-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-2-git-send-email-al.kochet@gmail.com>
Message-ID: <20161205222242.7wqzqg3c7z2jibmg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 07:14:44PM +0300, Alexander Kochetkov wrote:
> Make all properties description in form '"rockchip,<chip>-timer",
> "rockchip,rk3288-timer"' for all chips found in linux kernel.
> 
> Suggested-by: Heiko St?bner <heiko@sntech.de>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  .../bindings/timer/rockchip,rk-timer.txt           |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
