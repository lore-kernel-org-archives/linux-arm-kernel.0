From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 14 Sep 2010 16:59:22 +0900
Subject: [PATCH V3] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100909095347.GA9112@game.jcrosoft.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<20100909095347.GA9112@game.jcrosoft.org>
Message-ID: <20100914075922.GH7336@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 09, 2010 at 11:53:47AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:39 Thu 02 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> > factorise some generic infrastructure to assist looking up struct clks
> > for the ARM & SH architecture.
> > 
> > as the code is identical at 99%
> > 
> > put the arch specific code for allocation as example in asm/clkdev.h
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> is it ok?
> 
It's fine with me, but this will want to go via the ARM tree. You'll
probably want to submit this to the ARM patch tracker, and you can add my
Acked-by for the SH and SH-Mobile bits.
