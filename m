From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 15:23:07 -0500
Subject: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <20181026144344.27778-18-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com>
Message-ID: <20181030202307.GA13705@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2018 20:13:36 +0530, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> bridge panel, which is available on same PCB with 24-bit RGB interface.
> 
> So, this patch adds DSI specific binding details on existing
> dt-bindings file.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Use existing binding doc and update dsi details
> Changes for v2:
> - none
> 
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
