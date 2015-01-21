From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 21 Jan 2015 11:13:06 -0800
Subject: [PATCHv3 1/2] usb: ehci-platform: add support for multiple phys
 per controller
In-Reply-To: <Pine.LNX.4.44L0.1501211002380.1670-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1501211002380.1670-100000@iolanthe.rowland.org>
Message-ID: <54BFFA42.4010506@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Alan. I did run check patch and I had no errors or warnings.

I explained my changes in v3 in the cover patch, did that not come 
through or is it convention to do it in the individual patch?

Is the ack for the ohci patch as well? Thanks

Arun Ramamurthy

On 15-01-21 07:03 AM, Alan Stern wrote:
> On Mon, 19 Jan 2015 arun.ramamurthy at broadcom.com wrote:
>
>> From: Arun Ramamurthy <arunrama@broadcom.com>
>>
>> Added support for cases where one controller is connected
>> to multiple phys.
>>
>> Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Tested-by: Scott Branden <sbranden@broadcom.com>
>> ---
>
> Right here is where you should explain how v3 of this patch is
> different from v2.
>
> Anyway, it looks good.
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>
> Did you run it through checkpatch.pl?
>
> Alan Stern
>
