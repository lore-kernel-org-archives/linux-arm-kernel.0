From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 5 Dec 2017 18:50:01 -0500
Subject: [PATCH v4] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <f5ca26d2-9432-2ae3-7501-5b3dcf1e1486@linux.intel.com>
References: <1512397671-28733-1-git-send-email-awallis@codeaurora.org>
 <1512440100.17567.172.camel@mhfsdcap03>
 <99ea0ee4-1fff-73df-d9b5-0f756dfc5635@codeaurora.org>
 <f5ca26d2-9432-2ae3-7501-5b3dcf1e1486@linux.intel.com>
Message-ID: <7df62698-d27f-a7fc-f61e-60586c16f14b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On 12/5/2017 3:48 AM, Mathias Nyman wrote:
> On 05.12.2017 04:54, Adam Wallis wrote:
>> On 12/4/2017 9:15 PM, Chunfeng Yun wrote:
>>> On Mon, 2017-12-04 at 09:27 -0500, Adam Wallis wrote:
>>>> The xHCI driver currently has the IMOD set to 160, which
[..]
> 
> If Rob Acks this version I'll apply it and remove that blank line.
> 
> -Mathias
> 

Let me know if you have any other issues with this patch, otherwise with your
ACK, we are done.

Thanks

Adam

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
