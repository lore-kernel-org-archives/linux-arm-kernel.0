From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 24 Feb 2016 15:40:32 +0200
Subject: [PATCH 0/2] usb: dwc2: Remove host and gadget only code from core
In-Reply-To: <56CC26ED.50004@synopsys.com>
References: <cover.1456213319.git.johnyoun@synopsys.com>
 <56CC26ED.50004@synopsys.com>
Message-ID: <87mvqqjkfj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

John Youn <John.Youn@synopsys.com> writes:
> On 2/23/2016 12:35 AM, John Youn wrote:
>> This series moves the host/gadget-specific code from core.c to hcd.c
>> and gadget.c so that they will be compiled only when their respective
>> configurations are selected, or in DRD.
>> 
>> This is mostly just a straight move of the code. I have also added
>> some comments to group related functions together.
>> 
>> Compiled and tested in all three modes.
>> 
>> This should also solve the issue reported here:
>> http://marc.info/?l=linux-usb&m=145591813410106&w=2
>> 
>> Although I wasn't able to test it... couldn't figure out how to
>> disable CONFIG_USB and enable DWC2 in gadget mode.
>> 
>> Felipe,
>> 
>> This should be applied after Doug's series on your testing/next
>> branch.
>> 
>> 
>
> Hi Felipe,
>
> Patch 2/2 is triggering our corporate mail filters however I try to
> send it. I'll look into this with IT tomorrow, maybe have to send it
> from another account.

okay, I don't have patch 2/2. 1/2 is now in testing/next

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/0164cfa4/attachment-0001.sig>
