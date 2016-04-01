From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:08:47 -0500
Subject: [PATCH 3/3] clk: sunxi: Add sun8i PLL audio support
In-Reply-To: <8ba2e0d78c70ea4c54fb25969956fc31674df612.1459358017.git.moinejf@free.fr>
References: <cover.1459358017.git.moinejf@free.fr>
 <8ba2e0d78c70ea4c54fb25969956fc31674df612.1459358017.git.moinejf@free.fr>
Message-ID: <20160401170847.GA4480@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 06:57:16PM +0200, Jean-Francois Moine wrote:
> Add the PLL type which is used by the sun8i family for audio.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

And the 1 by 1 sunxi clock bindings continue...

>  drivers/clk/sunxi/clk-sunxi.c                     | 48 +++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
