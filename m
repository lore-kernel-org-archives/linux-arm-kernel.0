From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 10:25:06 -0500
Subject: [PATCH 2/5] clk: mvebu: ap806: do not depend anymore of the
 *-clock-output-names
In-Reply-To: <83d2035a1d00773c8e4c4d09134c81b0cd24152c.1495209464.git-series.gregory.clement@free-electrons.com>
References: <cover.fd6093dbad53cdac70eef4e53b238768721218ac.1495209464.git-series.gregory.clement@free-electrons.com>
 <83d2035a1d00773c8e4c4d09134c81b0cd24152c.1495209464.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170523152506.ooa2hoyzfssbozid@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:58:02PM +0200, Gregory CLEMENT wrote:
> As it was done for the cp110, this patch modifies the way the clock names
> are created. The name of each clock is now created by using its physical
> address as a prefix (as it was done for the platform device
> names). Thanks to this we have an automatic way to compute a unique name.
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt |  4 ----
>  drivers/clk/mvebu/ap806-system-controller.c                               | 46 ++++++++++++++++++++++++----------------------
>  2 files changed, 24 insertions(+), 26 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
