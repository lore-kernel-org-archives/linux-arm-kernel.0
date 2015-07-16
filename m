From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 16 Jul 2015 10:16:46 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdavWungUrU02dxObW1BUK5uELFHgDQMXmQwqdzzem2zuA@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
 <CACRpkdavWungUrU02dxObW1BUK5uELFHgDQMXmQwqdzzem2zuA@mail.gmail.com>
Message-ID: <60651945-976B-42B3-AD64-769AB10990C2@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 16 Jul 2015, at 9:52 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> On Thu, Jul 2, 2015 at 9:05 AM, Michael van der Westhuizen
> <michael@smart-africa.com> wrote:
> 
>> In my case, I have quite a lot of vendor-supplied code that needs the numbers to
>> be stable and backward compatible.  This quickly devolves into a discussion of
>> GPIOs in sysfs as an ABI, which is not a discussion I want to have :)
> 
> That is impossible to avoid.
> 
> What you're saying is you just want to drill a hole in the boat and not
> have a discussion whether the boat is going to float after this or
> not.

Not at all.  I was just noting that this patch will touch on this topic, and it?s not a
topic that I would weigh in on as my opinions are irrelevant in this discussion.

No incendiary topic intended :-)

Michael
