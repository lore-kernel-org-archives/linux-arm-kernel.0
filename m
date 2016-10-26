From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Oct 2016 14:31:31 -0700
Subject: MAINTAINERS entry for ARM/CLKDEV SUPPORT
In-Reply-To: <20161026191938.GT4418@mwanda>
References: <20161010140810.GA30609@mwanda>
 <20161010141819.GA1041@n2100.armlinux.org.uk> <20161026191938.GT4418@mwanda>
Message-ID: <663e5d47-c2b5-c76f-01b4-0fb9a792acf6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 12:19 PM, Dan Carpenter wrote:
> On Mon, Oct 10, 2016 at 03:18:19PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 10, 2016 at 05:08:10PM +0300, Dan Carpenter wrote:
>>> Hello Stephen Boyd,
>> Okay, that's really not nice.
>>
>> This is _not_ a question for Stephen.  Stephen does _not_ co-maintain
>> clkdev or the clk API, but co-maintains CCF.  I've no idea why you are
>> addressing this to Stephen when this is clearly a question for me to
>> answer.
>>
> Sorry, I didn't mean to offend.  He's the one who deleted the clkdev.h
> file though so I thought he might know if it should still be listed or
> if it was gone for good.
>

Yes, the arm version isn't coming back. We should delete
arch/arm/include/asm/clkdev.h from the maintainers file and perhaps
replace it with the asm-generic one. But we can delete the generic file
too once blackfin removes their clkdev.h header. That patch is still
outstanding.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
