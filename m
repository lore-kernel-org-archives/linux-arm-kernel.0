From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 28 Jan 2017 12:30:11 +0000
Subject: [PATCH v4 1/3] Documentation: dt-bindings: add the Amlogic Meson
 SAR ADC documentation
In-Reply-To: <20170123204432.2lkh3zlgzmwye3hj@rob-hp-laptop>
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
 <20170122181714.6259-2-martin.blumenstingl@googlemail.com>
 <20170123204432.2lkh3zlgzmwye3hj@rob-hp-laptop>
Message-ID: <4611e3bf-8e25-9f7c-7c34-6eca85ffc3d6@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/17 20:44, Rob Herring wrote:
> On Sun, Jan 22, 2017 at 07:17:12PM +0100, Martin Blumenstingl wrote:
>> This adds the devicetree binding documentation for the SAR ADC found in
>> Amlogic Meson SoCs.
>> Currently only the GXBB, GXL and GXM SoCs are supported.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  .../bindings/iio/adc/amlogic,meson-saradc.txt      | 32 ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
