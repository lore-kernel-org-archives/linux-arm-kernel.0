From: w@1wt.eu (Willy Tarreau)
Date: Sat, 17 Nov 2012 07:48:30 +0100
Subject: [PATCH v7] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
In-Reply-To: <20121115090257.4b9e20c5@skate>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121114.215922.1242337385782766449.davem@davemloft.net>
 <20121115083319.76483256@skate>
 <20121115.024213.1356436436054345008.davem@davemloft.net>
 <20121115090257.4b9e20c5@skate>
Message-ID: <20121117064830.GB647@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Nov 15, 2012 at 09:02:57AM +0100, Thomas Petazzoni wrote:
> David,
> 
> On Thu, 15 Nov 2012 02:42:13 -0500 (EST), David Miller wrote:
> > From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Date: Thu, 15 Nov 2012 08:33:19 +0100
> > 
> > > Would you mind if we take, with your Ack, the network driver through
> > > the arm-soc tree, so that we can carry the related patches modifying
> > > the Device Tree and so on? If not, then I'll send you a pull request
> > > with just the drivers/net changes, and we'll integrate the ARM-related
> > > changes through the arm-soc tree, in which we will have the necessary
> > > dependencies. I'm fine with any of those solutions.
> > 
> > Sure, no problem, take it via the ARM tree:
> > 
> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> Excellent, thanks!

Your patch set works fine on my mirabox, feel free to add my tested-by
to the patch set if you want :

   Tested-By: Willy Tarreau <w@1wt.eu>

Nice work!

Willy
