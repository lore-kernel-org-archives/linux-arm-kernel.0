From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:05:55 -0500
Subject: [PATCH 1/3] clk: sunxi: Add sun6i/8i display support
In-Reply-To: <2b347763e38cfeeb7a2d6af6357eaea6c4ec07ac.1459358017.git.moinejf@free.fr>
References: <cover.1459358017.git.moinejf@free.fr>
 <2b347763e38cfeeb7a2d6af6357eaea6c4ec07ac.1459358017.git.moinejf@free.fr>
Message-ID: <20160401170555.GA2962@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 06:43:29PM +0200, Jean-Francois Moine wrote:
> Add the clock type which is used by the sun6i/8i families for video display.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-sunxi.c                     | 38 +++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
