From: sthokal@xilinx.com (Srikanth Thokala)
Date: Mon, 18 Aug 2014 15:07:08 +0530
Subject: [PATCH v2 1/2] dma: Add Xilinx Central DMA DT Binding
 Documentation
In-Reply-To: <53E0C70E.2010603@gmail.com>
References: <1407238791-3370-1-git-send-email-sthokal@xilinx.com>
 <53E0C70E.2010603@gmail.com>
Message-ID: <CA+mB=1+coeN9Qcm_CmEwzK4fETiWdZdcskcxjcFNEomjN98sKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varka Bhadram,

On Tue, Aug 5, 2014 at 5:29 PM, Varka Bhadram <varkabhadram@gmail.com> wrote:
> On 08/05/2014 05:09 PM, Srikanth Thokala wrote:
>>
>> Device-tree binding documentation of Xilinx Central DMA Engine
>>
>> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
>> ---
>> Changes in v2:
>> - Change property 'xlnx,data-width' to 'xlnx,datawidth' in the description
>>    to match the implementation.
>>
>> ---
>>   .../devicetree/bindings/dma/xilinx/xilinx_cdma.txt |   54
>> ++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/dma/xilinx/xilinx_cdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_cdma.txt
>> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_cdma.txt
>> new file mode 100644
>> index 0000000..b04f76b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_cdma.txt
>> @@ -0,0 +1,54 @@
>> +Xilinx AXI CDMA engine, it does transfers between memory-mapped source
>> +address and a memory-mapped destination address.
>> +
>> +Required properties:
>> +- compatible: Should be "xlnx,axi-cdma-1.00.a"
>> +- #dma-cells: Should be <1>, see "dmas" property below
>> +- reg: Should contain cdma registers location and length.
>> +- dma-channel child node: Should have only one channel
>> +
>> +
>
>
> proper alignment for all the properties...
> Required properties:
> - compatible    : Should be "xlnx,axi-cdma-1.00.a"
>
> - #dma-cells    : Should be <1>, see "dmas" property below
> - reg           : Should contain cdma registers location and length.
> .....

I would like to change, but is it documented anywhere? Because, I didn't
receive any such comments on other drivers, so I am just wondering.

Thanks
Srikanth

>
>
>
> --
> Regards,
> Varka Bhadram.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
