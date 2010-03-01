From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 1 Mar 2010 16:42:20 -0000 (GMT)
Subject: Current status of interrupt handling capability of pca953x
	gpio  driver.
In-Reply-To: <eedb5541003010818r3a917a42rc973a4a74076a27@mail.gmail.com>
References: <eedb5541003010818r3a917a42rc973a4a74076a27@mail.gmail.com>
Message-ID: <3131fcab4adc999286a99435352e1deb.squirrel@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, March 1, 2010 16:18, javier Martin wrote:
> Hi,
> I saw a recent mail from Marc Zyngier on December about adding interrupt
> handling capability to pca953x gpio driver. (
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006651.html
> )
> There has not been any activity since then (or at least I couldn't find
> anything). What is the status regarding to mainline of these features?
>
> Have changes proposed by Marc Zyngier accepted? If not, what points have to
> be improved?

The patch is currently at it's 4th iteration (posted in February on LKML
http://lkml.org/lkml/2010/2/5/282) and sitting in Andrew Morton's mm tree.
It also has been successfully used on Blackfin boards.

When it comes to mainline merging, I really have no clue. The patch received very
little public comment (I only received a few private emails from people using it).

So if someone higher up in the food chain wants to carry that patch in his tree
and push it upstream, I can give it a respin.

        M.
-- 
And if you don't know where you're going, any road will take you there...
