From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Mar 2017 17:21:24 -0500
Subject: [PATCH v2 03/20] ARM: sun8i: dt: Add DT bindings documentation
 for Allwinner dwmac-sun8i
In-Reply-To: <20170314141856.24560-4-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
 <20170314141856.24560-4-clabbe.montjoie@gmail.com>
Message-ID: <20170320222124.iiko4ovjcgn6575r@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 03:18:39PM +0100, Corentin Labbe wrote:
> This patch adds documentation for Device-Tree bindings for the
> Allwinner dwmac-sun8i driver.

"dt-bindings: net: ..." is the preferred subject prefix if you respin.
 
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/net/dwmac-sun8i.txt        | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt

Acked-by: Rob Herring <robh@kernel.org>
