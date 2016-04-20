From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Apr 2016 08:32:30 -0700
Subject: Regression in next for smsc911x with tigthen lockdep checks
In-Reply-To: <57179EC9.6000505@stressinduktion.org>
References: <20160420150108.GF5995@atomide.com>
 <57179EC9.6000505@stressinduktion.org>
Message-ID: <20160420153230.GI5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hannes Frederic Sowa <hannes@stressinduktion.org> [160420 08:24]:
> Hi,
> 
> On 20.04.2016 17:01, Tony Lindgren wrote:
> > Looks like commit fafc4e1ea1a4 ("sock: tigthen lockdep checks for
> > sock_owned_by_user") in next causes a regression at least for
> > smsc911x with CONFIG_LOCKDEP. It keeps spamming with the following
> > message. Any ideas?
> 
> Not yet, can you quickly send me your config?

It's just the arch/arm/configs/omap2plus_defconfig I'm using.

Tony
