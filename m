From: robh@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 10:04:31 -0500
Subject: [PATCH v3 08/16] dt-bindings: Add bindings for phy-da8xx-usb
In-Reply-To: <1458863503-31121-9-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-9-git-send-email-david@lechnology.com>
Message-ID: <20160325150431.GA7194@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 06:51:33PM -0500, David Lechner wrote:
> Device tree binding for new phy-da8xx-usb driver.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v3 changes:
> 
> * added cfgchip info and example
> * correct usage of "DA8xx"
> * correct address after @
> * dropped 11 before @ in usb@
> 
> 
>  .../devicetree/bindings/phy/phy-da8xx-usb.txt      | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-da8xx-usb.txt

Acked-by: Rob Herring <robh@kernel.org>
