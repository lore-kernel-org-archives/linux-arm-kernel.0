From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 02 May 2011 14:45:03 -0400 (EDT)
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <alpine.LFD.2.00.1105021354410.24613@xanadu.home>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
	<BANLkTikCBDCYr6BHz4zWPvHfuAQ+eCtvNg@mail.gmail.com>
	<alpine.LFD.2.00.1105021354410.24613@xanadu.home>
Message-ID: <alpine.LFD.2.00.1105021434230.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 May 2011, Nicolas Pitre wrote:

> On Mon, 2 May 2011, Konstantin Porotchkin wrote:
> 
> > Hello, Nico,
> > 
> > I believe the past two patches were OK. Are you going to integrate them?
> 
> Yes, I just did that.

BTW, does this mean that all PJ4's are ARMv7 capable now?

If so, can the PJ4 entry in arch/arm/mm/proc-v6.s be removed?


Nicolas
