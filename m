From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Mar 2012 11:53:14 -0700
Subject: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
 (Tarun Kanti DebBarma's message of "Fri, 9 Mar 2012 14:16:52 +0530")
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
 <CAC83ZvJXK-FsiqyQT6BQxggRewkiHZkRBi44CVH15gb4dUbsjw@mail.gmail.com>
Message-ID: <87ehsxy7l1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Wed, Mar 7, 2012 at 4:45 PM, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
>> This local variable is just assigned zero and then OR'ed
>> with isr. It does not appear to serve any purpose and so
>> removing it.
> Missed following comments from Kevin given in v2. Sorry about that.
> I have updated the change in:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev
> for_3.4/gpio_further_cleanup_fixes
>
> "commit 672e302e3c (ARM: OMAP: use edge/level handlers from generic IRQ
> framework) removed retrigger support in favor of using generic IRQ
> framework.  This patch cleans up some unused remnants of that removal.

Ah, thanks.

Kevin
