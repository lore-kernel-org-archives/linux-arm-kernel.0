From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 16:09:17 -0600
Subject: [PATCH] clk: aspeed: Fix SDCLK name
In-Reply-To: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
References: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
Message-ID: <20180703220917.GA5938@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 09:55:25AM +0800, Lei YU wrote:
> The SDCLK was named SDCLKCLK, and no one has used this yet.
> Fix it.
> 
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---
>  drivers/clk/clk-aspeed.c                 | 2 +-

>  include/dt-bindings/clock/aspeed-clock.h | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 2 insertions(+), 2 deletions(-)
