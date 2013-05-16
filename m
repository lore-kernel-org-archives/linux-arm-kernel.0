From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Thu, 16 May 2013 17:18:00 +0530
Subject: [PATCH 2/6] ARM: davinci: dm365 evm: remove init_enable from
 ths7303 pdata
In-Reply-To: <CA+V-a8uU6QkYcMg1b5BPHbA0gUGypZeXZNScE-WLa-GqK4_fQA@mail.gmail.com>
References: <1368619042-28252-1-git-send-email-prabhakar.csengg@gmail.com>
 <1368619042-28252-3-git-send-email-prabhakar.csengg@gmail.com>
 <1928313.pnnBGKgv0p@avalon>
 <CA+V-a8uU6QkYcMg1b5BPHbA0gUGypZeXZNScE-WLa-GqK4_fQA@mail.gmail.com>
Message-ID: <CA+V-a8txWU=ohuJfmtKk5fQ_rh_qsp8wA72vUXWEDBZU1TJR-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, May 15, 2013 at 5:41 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> Hi Laurent,
>
> Thanks for the review.
>
> On Wed, May 15, 2013 at 5:35 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Prabhakar,
>>
>> Thank you for the patch.
>>
>> On Wednesday 15 May 2013 17:27:18 Lad Prabhakar wrote:
>>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>>
>>> remove init_enable from ths7303 pdata as it is no longer exists.
>>
>> You should move this before 1/6, otherwise you will break bisection.
>>
How about I just reshuffles while issuing a pull rather than resending
the whole series ?

Regards,
--Prabhakar Lad
