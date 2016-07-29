From: robh@kernel.org (Rob Herring)
Date: Fri, 29 Jul 2016 16:44:54 -0500
Subject: [PATCH v7 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <1469778856-24253-3-git-send-email-songjun.wu@microchip.com>
References: <1469778856-24253-1-git-send-email-songjun.wu@microchip.com>
 <1469778856-24253-3-git-send-email-songjun.wu@microchip.com>
Message-ID: <20160729214454.GA21408@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 03:54:08PM +0800, Songjun Wu wrote:
> DT binding documentation for ISC driver.
> 
> Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
> ---
> 
> Changes in v7: None
> Changes in v6:
> - Add "iscck" and "gck" to clock-names.
> 
> Changes in v5:
> - Add clock-output-names.
> 
> Changes in v4:
> - Remove the isc clock nodes.
> 
> Changes in v3:
> - Remove the 'atmel,sensor-preferred'.
> - Modify the isc clock node according to the Rob's remarks.
> 
> Changes in v2:
> - Remove the unit address of the endpoint.
> - Add the unit address to the clock node.
> - Avoid using underscores in node names.
> - Drop the "0x" in the unit address of the i2c node.
> - Modify the description of 'atmel,sensor-preferred'.
> - Add the description for the ISC internal clock.
> 
>  .../devicetree/bindings/media/atmel-isc.txt        | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt

Please add acks when posting new versions.

Rob
