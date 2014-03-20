From: imp@bsdimp.com (Warner Losh)
Date: Thu, 20 Mar 2014 11:44:43 -0600
Subject: [PATCH 2/3] mtd: davinci-nand: add dts property for
 NAND_NO_SUBPAGE_WRITE option
In-Reply-To: <532B2766.6090506@ti.com>
References: <1395335184-4745-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1395335184-4745-3-git-send-email-ivan.khoronzhuk@ti.com>
 <532B2183.2080309@ti.com> <20140320172912.GW31517@norris-Latitude-E6410>
 <532B2766.6090506@ti.com>
Message-ID: <D69011BE-C37F-4085-B992-45F6F32AF1D0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 20, 2014, at 11:37 AM, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> 
> 
> On Thursday 20 March 2014 01:29 PM, Brian Norris wrote:
>> On Thu, Mar 20, 2014 at 01:12:35PM -0400, Santosh Shilimkar wrote:
>>> Boris,
>> 
>> Who's Boris? And why should Boris be taking this patch? It's an MTD
>> patch.
>> 
> I got your name completely wrong. Sorry....
> 
>>> On Thursday 20 March 2014 01:06 PM, Ivan Khoronzhuk wrote:
>>>> From: Murali Karicheri <m-karicheri2@ti.com>
>>>> 
>>>> After testing NAND flash with ubifs for k2hk-emv board were committed
>>>> that flash doesn't support subpage writing, so we can fix it by
>>>> adding a property to disable subpage write.
>> 
>> What flash? We try to autodetect NAND as much as possible. Perhaps we
>> should be adding infrastructure support instead of hacking it with a DT
>> property.
>> 
> We can't auto detect it and thats why the DT approach was taken. We
> will double check that.

I though sub page writing was one of the fields in the onfi and/or jedec(toggle) meta data structures. Have you looked there?

Warner
