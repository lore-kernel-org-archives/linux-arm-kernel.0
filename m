From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 2 Jun 2014 11:44:13 +0200
Subject: [PATCH 0/5] ARM: Berlin: SMP support
In-Reply-To: <20140602093532.GF28090@lunn.ch>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <20140602093532.GF28090@lunn.ch>
Message-ID: <20140602094413.GA7865@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Jun 02, 2014 at 11:35:32AM +0200, Andrew Lunn wrote:
> On Mon, Jun 02, 2014 at 11:21:01AM +0200, Antoine T?nart wrote:
> > This series adds the SMP support for Marvell Berlin BG2 and BG2Q.
> > 
> > This implementation takes advantage of the reset exception register and
> > the software reset address register to make the CPUs execute the Berlin
> > secondary startup when being being reseted. This has the advantage of
> 
> One of these funny rules of English is that there is no word
> 'reseted'. It is just 'reset'. Also, one 'being' is enough!

Good to know! I'll update s/reseted/reset/ in all patches.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
