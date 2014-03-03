From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 3 Mar 2014 08:25:43 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1393595008.3802.35.camel@paszta.hi.pengutronix.de>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <1393595008.3802.35.camel@paszta.hi.pengutronix.de>
Message-ID: <53142067.2000208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 15:43, Philipp Zabel wrote:
> Hi Tomi,
> 
> Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
>> Add DT binding documentation for DVI Connector.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> new file mode 100644
>> index 000000000000..6a0aff866c78
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
>> @@ -0,0 +1,26 @@
>> +DVI Connector
>> +==============
>> +
>> +Required properties:
>> +- compatible: "dvi-connector"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
> 
> For the i.MX bindings I had called this property 'ddc', but
> Documentation/devicetree/bindings/panel/simple-panel.txt already
> uses 'ddc-i2c-bus'. We should definitely standardize this.

I like 'ddc-i2c-bus'.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/3f2b2a36/attachment.sig>
