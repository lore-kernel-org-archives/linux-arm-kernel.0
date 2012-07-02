From: keshava_mgowda@ti.com (Munegowda, Keshava)
Date: Mon, 2 Jul 2012 19:54:41 +0530
Subject: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
 issues.
In-Reply-To: <Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
References: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
 <Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
Message-ID: <CAP05o4+jmFba4z5UCoZWTnptnjUcw+OQT_69gxw42=S9zJCVLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2012 at 7:35 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 2 Jul 2012, Munegowda, Keshava wrote:
>
>> Hi Samuel
>>        please drop this patch for now , since Alan stern has mentioned
>> improvements for this patch and we
>> need to wait for Alan's new patch on ehci-omap.c and then Rus dill
>> patch and my usbhs tll
>> patch series need to be rebased.
>
> No, that's okay.  I rebased my patch on top of Russ's; see
>
>         http://marc.info/?l=linux-usb&m=134098478928668&w=2
>
> so Russ's patch should be kept.  My patch needed other changes also, so
> this wasn't a big deal.
>
> The extra problems I mentioned in an earlier email will still need to
> be fixed after both Russ's patch and my own are merged.
>
> Alan Stern

Thanks Alan,
            Ok, then I will rebase my TLL driver patch series on top
of this patch.

regards
keshava
