From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 29 Jan 2011 22:20:26 -0800
Subject: [PATCH 2/2] dmaengine: imx-sdma: fix inconsistent naming in
	sdma_assign_cookie()
In-Reply-To: <1295275164-7824-3-git-send-email-shawn.guo@freescale.com>
References: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
	<1295275164-7824-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <AANLkTimsm4M2+_O03kcSz4sFnLt2rRKAEvmF698TqLmV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 6:39 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Variable name sdma and sdmac are consistently used as the pointer to
> sdma_engine and sdma_channel respectively throughout the file. ?The
> patch fixes the inconsistency seen in function sdma_assign_cookie().
>
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---

Patch 1 and 2 applied.

Thanks,
Dan
