From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 11:15:23 -0500
Subject: [PATCH v2 14/23] spi: rockchip: add compatible string for rv1108
 spi
In-Reply-To: <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
 <1501663563-12482-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170810161523.vzmlgrmnex7yyepy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 04:46:03PM +0800, Andy Yan wrote:
> The spi on rv1108 is the same as other rockchip based
> socs, add compatible string for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
>  drivers/spi/spi-rockchip.c                             | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
