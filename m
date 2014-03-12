From: s-anna@ti.com (Suman Anna)
Date: Wed, 12 Mar 2014 12:22:26 -0500
Subject: [PATCH 00/10] arch/arm OMAP IOMMU patches for 3.15
In-Reply-To: <20140312170424.GA30897@atomide.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
 <531F84D6.8070101@ti.com> <20140312170424.GA30897@atomide.com>
Message-ID: <532097D2.4000002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 12:04 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [140311 14:52]:
>> Hi Paul,
>>
>> On 03/05/2014 06:24 PM, Suman Anna wrote:
>>> Hi Paul, Benoit,
>>>
>>> This is a repost as per Tony's request [3] of all the OMAP IOMMU DT support
>>> patches that are under arch/arm. The series just assimilates patches 8
>>> through 13 from the v3 OMAP IOMMU DT adaptation for 3.15 series [1], and
>>> all the v2 patches from the OMAP IOMMU DTS nodes [2].
>>>
>>> The only change made with respect to the patches above is in the OMAP4
>>> and OMAP5 DTS nodes - I have adjusted the reg sizes from 0xff to 0x100.
>>>
>>> Can you please provide your acks on the hwmod patches and DTS
>>> patches?
>>
>> Ping. Can you review and provide your acks for Patches 2 and 5 (the
>> hwmod patches) for Tony to pick up all the patches in the series?
>
> Applied all with Paul's acks into omap-for-v3.15/dt. As it's getting
> so late to the merge window, no guarantees it will actually get
> pulled.

Thanks Tony.

>
> For the pdata-quirks.c changes, I assume you are working on
> implementing the reset driver mentioned in the related patch?
>

Dan Murphy is currently working on this, and there is still some work to 
be done before it can be posted to the lists.

regards
Suman
