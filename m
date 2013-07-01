From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 02 Jul 2013 00:03:13 +0200
Subject: [PATCH] DMA: Fix Marvell Orion and mv_xor after MEMSET removal
In-Reply-To: <20130701144106.cf0cff602dbff596bf364de0@linux-foundation.org>
References: <1372690589-2218-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130701150407.GB19937@titan.lakedaemon.net>
 <20130701124205.9571b26975c1910ce5afa896@linux-foundation.org>
 <20130701213706.GF19937@titan.lakedaemon.net>
 <20130701144106.cf0cff602dbff596bf364de0@linux-foundation.org>
Message-ID: <51D1FCA1.10004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 11:41 PM, Andrew Morton wrote:
> On Mon, 1 Jul 2013 17:37:06 -0400 Jason Cooper<jason@lakedaemon.net>  wrote:
>
>>>> Please take a look at the email from lkml I just forwarded to you.  I
>>>> believe this solves your problem, but I don't have time to look closely
>>>> atm.
>>>
>>> Unhelpful.  Can the rest of us see this email as well please?
>>
>> Sorry about that, the thread I was referring to on lkml was here:
>>
>> http://comments.gmane.org/gmane.linux.kernel/1516018
>>
>> And the specific email I was referring to is here (second version of
>> Bartlomiej's patch which addresses what Sebastian was attempting to fix):
>>
>> http://permalink.gmane.org/gmane.linux.kernel/1517735
>
> Ah, OK, I have that:
>
> http://ozlabs.org/~akpm/mmots/broken-out/drivers-dma-remove-unused-support-for-memset-operations.patch

I guess, that is what is in next-20130701? My patch was based on it.

> http://ozlabs.org/~akpm/mmots/broken-out/drivers-dma-remove-unused-support-for-memset-operations-v3.patch

Bartlomeij sent another patch with all remaining differences between my
patch and the both above: https://lkml.org/lkml/2013/7/1/397

Sebastian
