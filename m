From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 3 Mar 2014 08:05:26 +0200
Subject: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI
 Panel
In-Reply-To: <1393594836.3802.32.camel@paszta.hi.pengutronix.de>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
 <1393594836.3802.32.camel@paszta.hi.pengutronix.de>
Message-ID: <53141BA6.4040702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 15:40, Philipp Zabel wrote:
> Am Freitag, den 28.02.2014, 14:20 +0200 schrieb Tomi Valkeinen:
>> Add DT binding documentation for MIPI DPI Panel.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Archit Taneja <archit@ti.com>
>> ---
>>  .../devicetree/bindings/video/panel-dpi.txt        | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/video/panel-dpi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Documentation/devicetree/bindings/video/panel-dpi.txt
>> new file mode 100644
>> index 000000000000..72636c6f1c67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
>> @@ -0,0 +1,43 @@
>> +Generic MIPI DPI Panel
>> +======================
>> +
>> +Required properties:
>> +- compatible: "panel-dpi"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the panel
>> +- gpios: panel enable gpio and backlight enable gpio
>> +
>> +Required nodes:
>> +- "panel-timing" containing video timings
>> +  (Documentation/devicetree/bindings/video/display-timing.txt)
>> +- Video port for DPI input
> 
> I don't see anything MIPI specific here. Couldn't this be added to the
> existing simple-panel binding?

Hmm, well, the simple-panel bindings doesn't define video ports, and not
even a common compatible property.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/b3d21203/attachment.sig>
