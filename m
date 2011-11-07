From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Nov 2011 07:28:36 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <alpine.LFD.2.02.1111062046320.3307@xanadu.home>
References: <20111031105740.GC29402@lunn.ch>
 <20111031152100.GR32165@titan.lakedaemon.net>
 <20111031164042.GD29402@lunn.ch>
 <201110312350.28475.michael@walle.cc>
 <20111106160538.GD19491@lunn.ch>
 <alpine.LFD.2.02.1111062046320.3307@xanadu.home>
Message-ID: <20111107062836.GG19491@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Beware. Moving the DRAM window setup code out of the various drivers is 
> not necessarily a good idea.  This setup is different from one 
> peripheral to another, and the associated registers are highly 
> peripheral specific.

Yes, i've noticed this. However, the core of the code is the same in
every case. So i think it should be possible. We will see.

      Andrew
