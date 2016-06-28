From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Jun 2016 16:37:48 +0200
Subject: [PATCH v4 0/4] dmaengine driver for Marvell XOR v2 engine
In-Reply-To: <20160628143850.GD14945@localhost>
References: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160628143850.GD14945@localhost>
Message-ID: <20160628163748.48bc2ad8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 28 Jun 2016 20:08:50 +0530, Vinod Koul wrote:
> On Thu, Jun 16, 2016 at 02:28:32PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Here is the fourth version of the mv_xor_v2 driver, which allows to
> > use the XOR engines available on the Marvell Armada 7K/8K ARM64 SoCs.  
> 
> Looks okay. But need ack on two ARM patches...

Thanks for the review! Please don't take the two ARM patches in your
tree, let the mvebu platform maintainer take them, to avoid conflicts.

So if you're happy with patches 1 and 2, could you take them? I'll talk
with the mvebu platform maintainer (who is in Cc) to get patches 3 and
4 merged.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
