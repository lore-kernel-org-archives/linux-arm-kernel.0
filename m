From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Jul 2014 22:23:26 +0200
Subject: mvebu: Can we make the orion-mdio clock a requirement?
In-Reply-To: <53CD743D.9080700@gmail.com>
References: <20140721190614.GB20027@arch.cereza>
 <20140721212818.2d4920c4@free-electrons.com>
 <53CD743D.9080700@gmail.com>
Message-ID: <20140721222326.668db913@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon, 21 Jul 2014 22:12:45 +0200, Sebastian Hesselbarth wrote:

> > However, yes, I tend to agree, making the clock mandatory would
> > probably be a good thing.
> 
> We can always pass TCLK on Orion5x if there is a need for a mandatory
> clock. Anyway, IIRC clock framework should now properly return
> -EPROPEDEFER only if there is a clock property set. If there is none,
> the error is different and can be catched on Orion5x.

Yes, I already use tclk on Orion5x for various clock references.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
