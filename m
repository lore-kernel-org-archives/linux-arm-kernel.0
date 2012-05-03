From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 May 2012 20:38:33 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <1336042485.13013.41.camel@sauron.fi.intel.com>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>
 <20120502144008.GF2194@S2101-09.ap.freescale.net>
 <1336042485.13013.41.camel@sauron.fi.intel.com>
Message-ID: <CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2012 18:54, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2012-05-02 at 22:40 +0800, Shawn Guo wrote:
>> Hi Artem,
>>
>> As the patch heavily depends on mxs device tree branch, I think it will
>> be easier to have it go through arm-soc tree. ?If you agree, can you
>> please give your ack if the patch looks fine to you?
>
> I do not mind if it goes via the arm-soc tree. I cannot really review
> this patch - it is too big, I think it should be split on smaller
> chunks.
>
Right.  I also think that the patch should at least be split into two,
one converts the driver to device tree and the other adds imx6q
support.  Shijie, can you do that?

Regards,
Shawn
