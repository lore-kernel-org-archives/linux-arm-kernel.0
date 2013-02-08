From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Fri, 8 Feb 2013 15:51:25 +0900
Subject: [PATCH RESEND] ARM: sched: correct update_sched_clock()
In-Reply-To: <20130206163355.GH17833@n2100.arm.linux.org.uk>
References: <1360128076-8555-1-git-send-email-iamjoonsoo.kim@lge.com>
 <CACRpkdbwoExxKbbvBKpt_Wh9KsgCXQW566N-0BaeL3oGY8pvLg@mail.gmail.com>
 <20130206163355.GH17833@n2100.arm.linux.org.uk>
Message-ID: <20130208065125.GA20440@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.

On Wed, Feb 06, 2013 at 04:33:55PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 06, 2013 at 10:33:53AM +0100, Linus Walleij wrote:
> > On Wed, Feb 6, 2013 at 6:21 AM, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> > 
> > > If we want load epoch_cyc and epoch_ns atomically,
> > > we should update epoch_cyc_copy first of all.
> > > This notify reader that updating is in progress.
> > 
> > If you think the patch is finished, put it into Russell's patch tracker:
> > http://www.arm.linux.org.uk/developer/patches/
> 
> Yea, this patch looks like the right thing... and yes, into the patch
> system please.

I try to put it into patch tracker, but I fail to put it.
I use following command.

git send-email --to patches at arm.linux.org.uk 0001-ARM-sched-correct~~~~~

Am I wrong?
Could you teach me how to put patch into your patch tracker?
I already read "help" on your website, but I can't find any stuff for
"git send-email".

Thanks.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
