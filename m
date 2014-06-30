From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Mon, 30 Jun 2014 08:56:00 +0530
Subject: [PATCH v2 1/2] usb: chipidea: zynq: Add device tree binding
 information
In-Reply-To: <53AD625B.1080002@cogentembedded.com>
References: <6233f866-678d-4a90-a307-debcb848ae76@BN1AFFO11FD023.protection.gbl>
 <53AD625B.1080002@cogentembedded.com>
Message-ID: <CAGnW=BZ7_SO3E3q23HSViBksEwp=BPWq5SXTROA3VJuYMBeDWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 5:53 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 06/27/2014 03:23 PM, Punnaiah Choudary Kalluri wrote:
>
>> Document device tree binding information as required by
>> the ZYNQ USB controller.
>
>
>> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
>
> [...]
>
>
>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt
>> b/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt
>> new file mode 100644
>> index 0000000..54bb3b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-zynq.txt
>> @@ -0,0 +1,23 @@
>> +Xilinx Zynq usb controller based on synopsys usb IP(v2.20a)
>
>
>    s/usb/USB/.

OK

>
>
>> +
>> +Required properties:
>> +- compatible:   should contain "xlnx,zynq-usb-2.20a"
>> +- clocks:       clock provider specifier
>> +- reg:          offset and length of the register set in the memory map
>> +- interrupt-parent: the phandle for the interrupt controller that
>> services
>> +                    interrupts for this device.
>
>
>    This property has never been required -- it can be inherited from the
> upper level node.

OK. i will correct it.

Thanks,
Punnaiah

>
> WBR, Sergei
>
>
