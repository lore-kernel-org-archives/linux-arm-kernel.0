From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2012 12:16:56 +0100
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023111019.GV4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
Message-ID: <20121023111656.GT21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:10:19PM +0100, Mark Brown wrote:
> On Tue, Oct 23, 2012 at 12:31:06PM +0200, Ulf Hansson wrote:
> > It seems like this patch did not get applied together with:
> > [PATCH 1/2] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
> > 
> > The problem was likely my fault, since there were a lot of resends.
> > Anyway, it should still be possible to apply.
> 
> I *really* should not need to remind you to:
> 
>  - Not top post
>  - Send patches in a form which can be applied if you want them applying

How about actually applying the damned patch from the two-part patch set,
rather than only the first, both of which has been around for almost a
month now, and fixes what should never have gone into mainline in the
first place?
