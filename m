From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 28 Mar 2012 07:42:33 +0200
Subject: [PATCH 02/10] clk: remove unnecessary EXPORT_SYMBOL_GPL
In-Reply-To: <CAJOA=zMEtyYuPwSAnnJ2PUnymkn-QWD7rJaymemH5on21EB4Sw@mail.gmail.com>
References: <20120327092828.GA16397@lunn.ch>
 <20120327131002.GC3719@S2101-09.ap.freescale.net>
 <CAJOA=zMEtyYuPwSAnnJ2PUnymkn-QWD7rJaymemH5on21EB4Sw@mail.gmail.com>
Message-ID: <20120328054233.GA2954@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I have a similar need for clk_divider_ops calls. ?Instead of exporting
> > every single clk_gate_ops call, we should just export "struct clk_ops
> > clk_gate_ops". ?That's exactly why I have the patch #4 here.
> 
> Andrew, does this approach work for you?  I prefer it over the EXPORT madness.

Hi Mike

I think so. I'm waiting for the first 3.4 RC to come out so I've not
tried implementing it yet.

      Andrew
