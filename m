From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:56:27 -0500
Subject: [PATCH v2 03/14] dt-bindings: document sun8i_ths - H3 thermal
 sensor driver
In-Reply-To: <20160625034511.7966-4-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-4-megous@megous.com>
Message-ID: <20160628205627.GM3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 05:45:00AM +0200, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> This patch adds the binding documentation for the
> sun8i_ths driver. This is a driver for thermal sensor
> found in Allwinner H3 SoC.
> 
> Signed-off-by: Ond?ej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/thermal/sun8i-ths.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

I guess the example will change for the clocks some, but otherwise:

Acked-by: Rob Herring <robh@kernel.org>
