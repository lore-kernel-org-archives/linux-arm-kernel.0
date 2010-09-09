From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 9 Sep 2010 11:53:47 +0200
Subject: [PATCH V3] arm & sh: factorised duplicated clkdev.c
In-Reply-To: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20100909095347.GA9112@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:39 Thu 02 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> factorise some generic infrastructure to assist looking up struct clks
> for the ARM & SH architecture.
> 
> as the code is identical at 99%
> 
> put the arch specific code for allocation as example in asm/clkdev.h
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
is it ok?

Best Regards,
J.
