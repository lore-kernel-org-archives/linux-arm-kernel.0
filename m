From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 15:27:23 -0500
Subject: [PATCH v3 19/25] dt-bindings: panel: Add Techstar TS8550B MIPI
 DSI panel
In-Reply-To: <20181026144344.27778-20-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-20-jagan@amarulasolutions.com>
Message-ID: <20181030202723.GA20468@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2018 20:13:38 +0530, Jagan Teki wrote:
> Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
> LCD panel. Add dt-bingings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
> 
>  .../display/panel/techstar,ts8550b.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
