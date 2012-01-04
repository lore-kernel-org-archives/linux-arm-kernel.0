From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Wed, 4 Jan 2012 15:33:11 -0800
Subject: [PATCH] ARM/bcmring: fix build error with sp804 clockevents init
In-Reply-To: <CAOesGMj1Jv0AqUHHovYLvDTWuz2Xp4UGZGmPxzzFpHd-cM83VA@mail.gmail.com>
References: <4F034B28.10706@broadcom.com>
 <CAOesGMj1Jv0AqUHHovYLvDTWuz2Xp4UGZGmPxzzFpHd-cM83VA@mail.gmail.com>
Message-ID: <4F04E1B7.5000201@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2012 2:12 PM, Olof Johansson wrote:
> Hi,
>
> On Tue, Jan 3, 2012 at 10:38 AM, Jiandong Zheng<jdzheng@broadcom.com>  wrote:
>> Wrong API sp804_clockevents_register() was used and caused build error.
>> So change to use sp804_clockevents_init().
>>
>> This patch was submitted a couple of times last year but unfortunately got
>> lost.
>
> Same with this patch as with the dma.c one: It's already fixed in
> mainline top of tree. What tree are you working against?
>
>
Yes, you are right. I forgot to check the latest in linus's tree and 
stays at 3.1.0.

Please discard this and another one in dma.c.

Thanks.
JD
