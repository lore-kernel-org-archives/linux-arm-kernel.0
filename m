From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Wed, 5 Jul 2017 14:48:15 +0000
Subject: [PATCH v2 1/7] DT bindings: add bindings for ov965x camera module
In-Reply-To: <20170705140305.pixlhd65xu6g3nlf@rob-hp-laptop>
References: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
 <1499073368-31905-2-git-send-email-hugues.fruchet@st.com>
 <20170705140305.pixlhd65xu6g3nlf@rob-hp-laptop>
Message-ID: <6fa2e20e-ac19-0296-d481-f0cb4aa4a231@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/05/2017 04:03 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 11:16:02AM +0200, Hugues Fruchet wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>
>> This adds documentation of device tree bindings
>> for the OV965X family camera sensor module.
>>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
>> ---
>>   .../devicetree/bindings/media/i2c/ov965x.txt       | 45 ++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/ov965x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ov965x.txt b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
>> new file mode 100644
>> index 0000000..4ceb727
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
>> @@ -0,0 +1,45 @@
>> +* Omnivision OV9650/9652/9655 CMOS sensor
>> +
>> +The Omnivision OV965x sensor support multiple resolutions output, such as
>> +CIF, SVGA, UXGA. It also can support YUV422/420, RGB565/555 or raw RGB
>> +output format.
>> +
>> +Required Properties:
>> +- compatible: should be one of
>> +	"ovti,ov9650"
>> +	"ovti,ov9652"
>> +	"ovti,ov9655"
>> +- clocks: reference to the mclk input clock.
>> +
>> +Optional Properties:
>> +- resetb-gpios: reference to the GPIO connected to the RESETB pin, if any,
>> +		polarity is active low.
> 
> reset-gpios
> 
>> +- pwdn-gpios: reference to the GPIO connected to the PWDN pin, if any,
>> +		polarity is active high.
> 
> powerdown-gpios
> 
> Both are standardish names for such signals.
> 
> Rob

Thanks Rob, I will fix,
Hugues.

> 
