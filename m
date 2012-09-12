From: csd@broadcom.com (Christian Daudt)
Date: Wed, 12 Sep 2012 08:17:32 -0700
Subject: [PATCH 1/3] ARM: Remove bcmring NAND driver
In-Reply-To: <20120912095741.GY13739@n2100.arm.linux.org.uk>
References: <505044E3.3040601@broadcom.com>
 <20120912095130.GN32234@mudshark.cambridge.arm.com>
 <20120912095741.GY13739@n2100.arm.linux.org.uk>
Message-ID: <5050A78C.4000700@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-09-12 02:57 AM, Russell King - ARM Linux wrote:
> On Wed, Sep 12, 2012 at 10:51:31AM +0100, Will Deacon wrote:
>> Hi Christian,
>>
>> On Wed, Sep 12, 2012 at 09:16:35AM +0100, Christian Daudt wrote:
>>> This driver is being removed as part of the cleanup of the bcmring
>>> SoC from mainline as it is no longer maintained.
>>>
>>> Signed-off-by: Christian Daudt<csd@broadcom.com>
>>> Reviewed-by: Jiandong Zheng<jdzheng@broadcom.com>
>> This is really good to see, thanks. I guess the other two patches in your
>> series were too large and are being held for moderation by the list?
> They have typos in the list address.
>
patch 2/3 is awaiting moderator approval. The linux-mtd cc is here: 
http://lists.infradead.org/pipermail/linux-mtd/2012-September/043945.html
patch 3/3 had a email address typo but Russell said it should not be 
applied, so I won't bother resending. The linux-mtd cc is here: 
http://lists.infradead.org/pipermail/linux-mtd/2012-September/043946.html

   thanks,
    Christian.
