From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Mon, 30 Mar 2015 13:28:58 -0700
Subject: [PATCH net-next] ethernet: Use bool function returns of
 true/false instead of 1/0
In-Reply-To: <1427678712.2715.52.camel@perches.com>
References: <201503260524.AdqSbov9%fengguang.wu@intel.com>
 <20150325215525.GA26868@athens>
 <20150329.121655.2092434262655191613.davem@davemloft.net>
 <1427678712.2715.52.camel@perches.com>
Message-ID: <1427747338.2497.99.camel@jtkirshe-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-03-29 at 18:25 -0700, Joe Perches wrote:
> Use bool constants as the return values instead of 1 and 0.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
For the ixgbe changes...

> ---
> > To be honest I'd might rather get bunches of these, there has to be
> a ton
> > of them, than a slow trickle of one every few weeks/days.
> 
> There aren't too many...
> 
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/1e752dd6/attachment-0001.sig>
