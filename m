From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 28 Feb 2017 08:58:41 +0530
Subject: [PATCH v2 14/22] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable legacy mode
In-Reply-To: <20170227164054.xcubjpaf2qx3pxol@rob-hp-laptop>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-15-git-send-email-kishon@ti.com>
 <20170227164054.xcubjpaf2qx3pxol@rob-hp-laptop>
Message-ID: <58B4EE69.6030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 27 February 2017 10:10 PM, Rob Herring wrote:
> On Fri, Feb 17, 2017 at 03:20:34PM +0530, Kishon Vijay Abraham I wrote:
>> Update device tree binding documentation of TI's dra7xx PCI
>> controller to include property for enabling legacy mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 190828a..72ebe2b 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -39,6 +39,10 @@ DEVICE MODE
>>   - interrupts : one interrupt entries must be specified for main interrupt.
>>   - num-ib-windows : number of inbound address translation windows
>>   - num-ob-windows : number of outbound address translation windows
>> + - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
>> +		       contain the register offset within syscon and the 2nd
>> +		       argument should contain the bit field for setting the
>> +		       legacy mode
> 
> Vendor prefix needed and what does "legacy mode" mean? Perhaps name this 
> around what the mode is/does, not that it is legacy.

All right, thanks!

-Kishon
