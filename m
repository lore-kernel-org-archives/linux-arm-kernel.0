From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 May 2012 16:48:11 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <20120514080835.GB31985@opensource.wolfsonmicro.com>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
 <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
 <20120514035137.GB20367@S2100-06.ap.freescale.net>
 <20120514080835.GB31985@opensource.wolfsonmicro.com>
Message-ID: <20120514084810.GD20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 09:08:36AM +0100, Mark Brown wrote:
> On Mon, May 14, 2012 at 11:51:38AM +0800, Shawn Guo wrote:
> 
> > From what I see, it's reasonable.  Then the immediate question I have
> > is, should we remove "struct anatop *adata" from anatop_read_reg and
> > anatop_write_reg completely?
> 
> Given the way these things tend to go it's probably guaranteeing that
> your next round of SoCs will have two register compatible anatop blocks :)

Considering anatop block tends to be a container of misc hardware
control bits, I haven't really seen any possibility that the future
SoCs will have multiple anatop blocks.

-- 
Regards,
Shawn
