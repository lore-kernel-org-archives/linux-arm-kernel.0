From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Feb 2013 16:33:55 +0000
Subject: [PATCH RESEND] ARM: sched: correct update_sched_clock()
In-Reply-To: <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
References: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
 <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
Message-ID: <20130206163355.GH17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 10:33:53AM +0100, Linus Walleij wrote:
> On Wed, Feb 6, 2013 at 6:21 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> 
> > If we want load epoch_cyc and epoch_ns atomically,
> > we should update epoch_cyc_copy first of all.
> > This notify reader that updating is in progress.
> 
> If you think the patch is finished, put it into Russell's patch tracker:
> http://www.arm.linux.org.uk/developer/patches/

Yea, this patch looks like the right thing... and yes, into the patch
system please.
