From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 25 Jul 2014 11:40:02 +0200
Subject: [PATCH v2 07/11] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <53D21983.8060901@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-8-git-send-email-afaerber@suse.de>
 <53D20C19.5000306@monstr.eu> <53D21983.8060901@suse.de>
Message-ID: <435f86ce-9588-48c7-b01a-5dd97ea64b13@BL2FFO11FD021.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 07/25/2014 10:46 AM, Andreas F?rber wrote:
> Hi Michal,
> 
> Am 25.07.2014 09:49, schrieb Michal Simek:
>> On 07/25/2014 01:00 AM, Andreas F?rber wrote:
>>> The specification requires xlnx,data-width, but example and driver use
>>> xlnx,datawidth. Change the specification to match the implementation.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  v2: New
>>>  
>>>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>>> index 1405ed0..e4c4d47 100644
>>> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>>> @@ -25,7 +25,7 @@ Required child node properties:
>>>  - compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
>>>  	"xlnx,axi-vdma-s2mm-channel".
>>>  - interrupts: Should contain per channel VDMA interrupts.
>>> -- xlnx,data-width: Should contain the stream data width, take values
>>> +- xlnx,datawidth: Should contain the stream data width, take values
>>>  	{32,64...1024}.
> 
> BTW I just notice that this values specification is ambiguous as to
> whether 96 is a valid value or only powers of 2 like 128. Maybe you want
> to clarify that in a follow-up patch?

really appreciate your help for improving this.
Srikanth T: Can you please look at it?

Thanks,
Michal



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/075d7662/attachment.sig>
