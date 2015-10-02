From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 2 Oct 2015 15:12:05 +0530
Subject: [PATCH v3 2/5] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <20151002093201.GA23213@x1>
References: <1439994175-13360-1-git-send-email-lee.jones@linaro.org>
 <1439994175-13360-3-git-send-email-lee.jones@linaro.org>
 <CABb+yY2wJKBvL3eceVxkq3ZdS6V+-yqQp98YCaS_oR+3CobQ0g@mail.gmail.com>
 <20151002093201.GA23213@x1>
Message-ID: <CAJe_ZheOw-zG5r-WUd6nYLLmw1QOL8GAXhOmPymm-z2v0oyAGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2015 at 15:02, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 02 Oct 2015, Jassi Brar wrote:
>
>> On Wed, Aug 19, 2015 at 7:52 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> ....
>>
>> > +
>> > +#define MBOX_BASE(mdev, inst)   ((mdev)->base + (inst * 4))
>> >
>> It should be    (inst) * 4
>
> I'm guessing you mean:
>
>   ((mdev)->base + ((inst) * 4))
>
> ?
yes.
