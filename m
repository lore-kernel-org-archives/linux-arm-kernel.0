From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 7 Aug 2013 23:24:38 -0700
Subject: [PATCH] mtd: atmel_nand: move the sanity check to the beginning
 of pmecc_enable()
In-Reply-To: <1375869491-25137-1-git-send-email-josh.wu@atmel.com>
References: <1375869491-25137-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130808062438.GA4479@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:58:11PM +0800, Josh Wu wrote:
> It is better to do the sanity check for the parameter before any hardware
> operation.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git. I would squash it into the original patch, but
David has already taken it into his tree. I'll leave it up to him, then.

Thanks,
Brian
