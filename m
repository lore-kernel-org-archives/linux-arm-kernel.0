From: taoren@fb.com (Tao Ren)
Date: Thu, 8 Nov 2018 02:31:32 +0000
Subject: [PATCH v2 1/2] ARM: dts: Add Facebook BMC flash layout
In-Reply-To: <1541641556.1495362.1569509568.7BE039CA@webmail.messagingengine.com>
References: <20181106042829.2771226-1-taoren@fb.com>
 <1541635320.1462459.1569430616.0F5E4C4D@webmail.messagingengine.com>
 <c5e56fc4-397f-a38b-6378-99eecce1180b@fb.com>
 <1541641556.1495362.1569509568.7BE039CA@webmail.messagingengine.com>
Message-ID: <62de5dcd-e8a2-9572-3b0b-fc3ca9d1875c@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 5:45 PM, Andrew Jeffery wrote:

>>> Is this necessary? Isn't the same thing achieved with the /dev/mtd0 device?
>>
>> Hi Andrew,
>>
>> Thank you for the review! The new layout file is needed mainly because 
>> of "data0" partition: several facebook platforms use the partition as 
>> "persistent" storage.
>>
>> As for "flash0", technically it's not needed (as you pointed out, /dev/
>> mtd0 covers the entire flash if master_partition is enabled). It's still 
>> here to avoid breaking some legacy applications.
> 
> This is what I expected. I think it might be worth adding a comment, given
> you are respinning the series to address my comments on the board
> devicetree patch.
> 
> Anyway, thanks for the clarification.
> 
> Andrew

Sure Andrew. I will add some comments and send out 2 updated patches together (most likely sometime tomorrow).

Thanks,
Tao Ren
