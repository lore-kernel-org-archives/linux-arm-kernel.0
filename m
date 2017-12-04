From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 14:24:43 -0600
Subject: [PATCH v6 1/2] media: ov7740: Document device tree bindings
In-Reply-To: <20171204065858.3138-2-wenyou.yang@microchip.com>
References: <20171204065858.3138-1-wenyou.yang@microchip.com>
 <20171204065858.3138-2-wenyou.yang@microchip.com>
Message-ID: <20171204202443.jiizsqu6yfpsugj4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 02:58:57PM +0800, Wenyou Yang wrote:
> Add the device tree binding documentation for the ov7740 sensor driver.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
>  - Explicitly document the "remote-endpoint" property.
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/media/i2c/ov7740.txt       | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt

Please add acks when posting new versions.

Rob
