From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:50:05 -0600
Subject: [PATCH 05/14] clk: sunxi: Add APB1 clock for A83T
In-Reply-To: <1454203266-4450-6-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-6-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160201145005.GA29776@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:57AM +0800, Vishnu Patekar wrote:
> APB1 is similar to sun4i-a10-apb0-clk, except different dividers.
> 
> This adds support for apb1 on A83T.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-sunxi.c                     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
