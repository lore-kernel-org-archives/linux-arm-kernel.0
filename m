From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Jun 2017 09:04:36 -0500
Subject: [PATCH v4 4/6] regulator: pfuze100: add fsl,pmic-stby-poweroff
 property
In-Reply-To: <20170609140739.15726-5-o.rempel@pengutronix.de>
References: <20170609140739.15726-1-o.rempel@pengutronix.de>
 <20170609140739.15726-5-o.rempel@pengutronix.de>
Message-ID: <20170618140436.a2owbfsij5k4vmvt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:07:37PM +0200, Oleksij Rempel wrote:
> Document the new optional "fsl,pmic-stby-poweroff" property.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/regulator/pfuze100.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
