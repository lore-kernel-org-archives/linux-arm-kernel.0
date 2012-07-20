From: ian.molton@codethink.co.uk (Ian Molton)
Date: Fri, 20 Jul 2012 16:35:41 +0100
Subject: SATA working on 370/XP, Ethernet next...
In-Reply-To: <20120720144133.GA15606@lunn.ch>
References: <20120720144133.GA15606@lunn.ch>
Message-ID: <50097ACD.9@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/12 15:41, Andrew Lunn wrote:
> Hi Ian
Hi!

Good to hear you got SATA working. What was wrong?



Window setup was wrong - mostly just the function setting it up simply 
not getting called.

I suspect that this platform rather badly needs the clock stuff 
implementing.

 > I'm interested in Ethernet. I assume it uses 
drivers/net/ethernet/marvell/mv643xx_eth.c?

AIUI, yes. I havent checked yet.

 > If so, your work should be applicable for all Orion devices, and i'm 
happy to test on kirkwood.

Cheers! :)

-Ian
