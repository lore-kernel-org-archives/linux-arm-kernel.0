From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 12 Feb 2016 17:25:02 +0000
Subject: [PATCH v2] iommu/io-pgtable: Rationalise quirk handling
In-Reply-To: <27989114.h36RDrXrhS@avalon>
References: <cover.1453723096.git.robin.murphy@arm.com>
 <62860b753f304beef7b4b6f1e13d7094252f2f37.1455294748.git.robin.murphy@arm.com>
 <27989114.h36RDrXrhS@avalon>
Message-ID: <56BE156E.3090707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/16 17:24, Laurent Pinchart wrote:
> Hi Robin,
>
> Thank you for the patch.
>
> On Friday 12 February 2016 17:09:46 Robin Murphy wrote:
>> As the number of io-pgtable implementations grows beyond 1, it's time
>> to rationalise the quirks mechanism before things have a chance to
>> start getting really ugly and out-of-hand.
>>
>> To that end:
>> - Indicate exactly which quirks each format can/does support.
>> - Fail creating a table if a caller wants unsupported quirks.
>> - Properly document where each quirk applies and why.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> Just to allay any confusion, I intend this as a followup to the
>> short-descriptor[1] and Mediatek IOMMU[2] patches, rather than a
>> crucial addition, so it can either get picked up along with those
>> or wait 'til later.
>>
>> v2:
>> - Use unsigned long for the bitmap.
>> - Do format-specific checks inline.
>> - Enough of a difference that I don't feel comfortable putting
>>    Laurent's reviewed-by from v1 on it...
>
> Here it is again.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Robin.
