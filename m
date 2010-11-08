From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 8 Nov 2010 17:48:42 -0600
Subject: [PATCH 3/6] OMAP4: hwmod data: add mmu hwmod for ducati and tesla
In-Reply-To: <4CD885DD.7020909@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
	<1289006396-27230-4-git-send-email-omar.ramirez@ti.com>
	<4CD5BEFF.40301@ti.com>
	<AANLkTim=5bgGo1cnkWJCPF4HmMnQrBhP_sPCK3rRKUPS@mail.gmail.com>
	<4CD885DD.7020909@ti.com>
Message-ID: <AANLkTi=JhdGqB-mXnvjT_Y4cCOu2i8bwfQyy=FAC1Chh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 8, 2010 at 5:21 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> I wrote this one from scratch, I didn't see that there were pieces to
>> handle some stuff since the code is buried in a private tree.
>
> Not true at all... It was sent to l-o:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg32854.html

I did review v3 of this patch set, care to point the exact place for
mmu hwmod on this patch set. It seems [v2 5/7] had mailbox, but I
don't think v3 made it to the list.

> And stored in a supposedly private tree, which appears to be public:
> http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=summary

I took whatever was in:

http://dev.omapzoom.org/?p=integration/kernel-omap4.git;a=shortlog;h=refs/heads/L24.11

> Please do not do any change on that code base, just use the original code
> and update it if needed.

Will do, as taken from the tree you mention.

Regards,

Omar
