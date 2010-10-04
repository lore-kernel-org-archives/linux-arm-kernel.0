From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Oct 2010 20:46:59 +0100
Subject: [PATCH V3] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <20100909095347.GA9112@game.jcrosoft.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<20100909095347.GA9112@game.jcrosoft.org>
Message-ID: <20101004194659.GC25241@n2100.arm.linux.org.uk>
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

Just applied it and dropped it - it seems to miss deleting the old files.
Please resubmit with the old files removed.

BTW, patch system understands git -C and -M patches.
