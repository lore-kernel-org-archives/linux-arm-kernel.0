From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Nov 2017 07:58:45 -0600
Subject: [PATCH v5 1/2] media: ov7740: Document device tree bindings
In-Reply-To: <20171128052259.4957-2-wenyou.yang@microchip.com>
References: <20171128052259.4957-1-wenyou.yang@microchip.com>
 <20171128052259.4957-2-wenyou.yang@microchip.com>
Message-ID: <20171128135845.k4fy4ayl3z7fsdvr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 01:22:58PM +0800, Wenyou Yang wrote:
> Add the device tree binding documentation for the ov7740 sensor driver.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
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

Acked-by: Rob Herring <robh@kernel.org>
