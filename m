From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:49:23 -0600
Subject: [PATCH 04/14] clk: sunxi: add ahb1 clock for A83T
In-Reply-To: <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160201144923.GA29286@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:56AM +0800, Vishnu Patekar wrote:
> AHB1 on A83T is similar to ahb1 on A31, except parents are different.
> clock index 0b1x is PLL6.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-sunxi.c                     | 75 +++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
