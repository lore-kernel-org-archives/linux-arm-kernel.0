From: snijsure@grid-net.com (Subodh Nijsure)
Date: Mon, 09 Apr 2012 09:11:59 -0700
Subject: Want to Get Suggestion for MX28 USB Submisson
In-Reply-To: <201204070334.20650.marek.vasut@gmail.com>
References: <35AB98346D25394A9354ED89C4D76587225CFF@039-SN1MPN1-002.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A6498096381@039-SN2MPN1-021.039d.mgd.msft.net>
 <201204030923.21892.marek.vasut@gmail.com>
 <201204070334.20650.marek.vasut@gmail.com>
Message-ID: <4F830A4F.4040909@grid-net.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2012 06:34 PM, Marek Vasut wrote:
> Dear Marek Vasut,
>
>> Dear Chen Peter-B29397,
>>
>>>> On Wed, Mar 14, 2012 at 12:30 AM, Chen Peter-B29397
>>>>
>>>> <B29397@freescale.com>  wrote:
>>>>> According to sascha's suggestion, it is better to re-submit after we
>>>> have
>>>>
>>>>> a generic USB PHY Layer in mainline.
>>>>>
>>>>> Currently, Heikki's split PHY from OTG structure patches have
>>>>> mainlined, next step is to submit a generic USB PHY driver.
>>>> Just for my understanding: is there someone working on this generic
>>>> USB PHY driver?
>>> Add related people.
>>>
>>> I have much internal stuff on hands now, and have not bandwidth to do it
>>> right now.
>> It's in my queue to look into this too, but it's still low prio biz.
> Ok, it just became high-prio biz ...
>
> I have the code in prototype phase, will submit it once customer signs the
> contract (likely next week).
We have ported USB driver from Freescale's 2.6.35 implementation to 
3.1-rc5 kernel. We are migrating from 3.1-rc5 to 3.4-rc1 so I am 
starting to look at this. Let me know if I can be of any help. I would 
be more than happy to test stuff you have.

-Subodh
