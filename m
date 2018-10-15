From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 13:24:48 -0500
Subject: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
In-Reply-To: <20180927114850.24565-10-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com>
Message-ID: <20181015182448.GA7134@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> same panel PCB comes with parallel RBG which is supported via
> panel-simple with "bananapi,s070wv20-ct16" compatible.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
