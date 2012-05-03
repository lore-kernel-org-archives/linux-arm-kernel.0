From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 3 May 2012 22:14:55 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>
 <20120502144008.GF2194@S2101-09.ap.freescale.net>
 <1336042485.13013.41.camel@sauron.fi.intel.com>
 <CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>
Message-ID: <CAMiH66EBO-MHXBb1eB4NMAJo6nPN47_42jYNGUGc=GC7oejPWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2012 at 8:38 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 3 May 2012 18:54, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>> On Wed, 2012-05-02 at 22:40 +0800, Shawn Guo wrote:
>>> Hi Artem,
>>>
>>> As the patch heavily depends on mxs device tree branch, I think it will
>>> be easier to have it go through arm-soc tree. ?If you agree, can you
>>> please give your ack if the patch looks fine to you?
>>
>> I do not mind if it goes via the arm-soc tree. I cannot really review
>> this patch - it is too big, I think it should be split on smaller
>> chunks.
>>
> Right. ?I also think that the patch should at least be split into two,
> one converts the driver to device tree and the other adds imx6q
> support. ?Shijie, can you do that?
ok, I will  do it tomorrow.

It's better that this patch is merged by l2-mtd, because this patch
depends on another patch which is
on the l2-mtd now.

Best Regards
Huang Shijie
