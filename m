From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 04 Dec 2013 09:32:37 +0100
Subject: [PATCH 3/3] usb: ohci-at91: use device managed clk retrieval
In-Reply-To: <Pine.LNX.4.44L0.1312031030390.1226-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1312031030390.1226-100000@iolanthe.rowland.org>
Message-ID: <529EE8A5.7010806@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan,

On 03/12/2013 16:32, Alan Stern wrote:
> On Tue, 3 Dec 2013, Nicolas Ferre wrote:
>
>> On 03/12/2013 15:07, Boris BREZILLON :
>>> Replace clk_get calls by devm_clk_get calls.
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>> Tested-by: Robert Nelson <robertcnelson@gmail.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Thanks Boris for these fixes.
>>
>> Alan, Greg, can you take the whole series as fixes for 3.13?
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Sorry, but I forgot to add your Signed-off-by in the 2nd version of this
series.
>
> The patches look fine to me.  But only the 1/3 patch fixes a bug; the
> others merely change the resource management.

Do you want me to split this series ?
  1) the 1st patch that should be merged in 3.13
  2) patches 2 to 4 that might be applied later

Best Regards,

Boris

>
> Alan Stern
>
