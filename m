From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 20:52:49 +0100
Subject: [PATCH 05/12] net: smc91x: Remove dead code
In-Reply-To: <1426270185-19510-6-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <2309042.KQEDUaQCkU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 11:09:38 Stephen Boyd wrote:
> This config no longer exists now that mach-msm has been removed.
> Delete it and the associated code.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> This can be acked and go through arm-soc or applied directly.
> 
>  drivers/net/ethernet/smsc/smc91x.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 

David Miller already merged a patch that removes this and the other
platform specific parts of that file that are no longer needed.

	Arnd
