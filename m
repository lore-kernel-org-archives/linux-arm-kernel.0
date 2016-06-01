From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 09:57:49 -0500
Subject: [RESEND PATCH 6/6] ASoC: rockchip: Add machine driver for cdn dp
 codec
In-Reply-To: <1464345942-4795-7-git-send-email-zyw@rock-chips.com>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-7-git-send-email-zyw@rock-chips.com>
Message-ID: <20160601145749.GA12362@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 06:45:42PM +0800, Chris Zhong wrote:
> The driver is used for cdn dp codec embedded in rk3399
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> 
> ---
> 
>  .../bindings/sound/rockchip-cdn-dp-audio.txt       |  12 ++

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/rockchip/Kconfig                         |   9 ++
>  sound/soc/rockchip/Makefile                        |   2 +
>  sound/soc/rockchip/rockchip-cdn-dp-audio.c         | 167 +++++++++++++++++++++
>  4 files changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt
>  create mode 100644 sound/soc/rockchip/rockchip-cdn-dp-audio.c
