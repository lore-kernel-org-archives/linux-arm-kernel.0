From: robh@kernel.org (Rob Herring)
Date: Thu, 6 Jul 2017 12:12:54 -0500
Subject: [PATCH 1/5] pwm: rockchip: Add APB and function both clocks
 support
In-Reply-To: <1498739271-27431-2-git-send-email-david.wu@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170706171254.cdjc4dwfwcoitm44@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 08:27:47PM +0800, David Wu wrote:
> New PWM module provides two individual clocks of APB clock
> and function clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  8 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pwm/pwm-rockchip.c                         | 53 ++++++++++++++++++----
>  2 files changed, 51 insertions(+), 10 deletions(-)
