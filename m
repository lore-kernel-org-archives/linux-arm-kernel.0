From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 12:00:12 -0500
Subject: [PATCH] clk: aspeed: Add 24MHz fixed clock
In-Reply-To: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
References: <1526633822-17138-1-git-send-email-mine260309@gmail.com>
Message-ID: <20180523170012.GA15670@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 04:57:02PM +0800, Lei YU wrote:
> Add a 24MHz fixed clock.
> This clock will be used for certain devices, e.g. pwm.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---
>  drivers/clk/clk-aspeed.c                 | 9 ++++++++-
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
