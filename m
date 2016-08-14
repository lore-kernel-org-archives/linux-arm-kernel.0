From: greg@kroah.com (Greg KH)
Date: Sun, 14 Aug 2016 17:44:34 +0200
Subject: [PATCH 1/2 (linux-stable-4.5.y)] Revert "stmmac: Fix 'eth0: No
 PHY found' regression"
In-Reply-To: <1464009463-23654-2-git-send-email-peppe.cavallaro@st.com>
References: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
 <1464009463-23654-2-git-send-email-peppe.cavallaro@st.com>
Message-ID: <20160814154434.GI20560@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 03:17:42PM +0200, Giuseppe Cavallaro wrote:
> From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
> 
> This reverts commit 88f8b1bb41c6208f81b6a480244533ded7b59493.
> due to problems on GeekBox and Banana Pi M1 board when
> connected to a real transceiver instead of a switch via
> fixed-link.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> Cc: Andreas F?rber <afaerber@suse.de>
> Cc: Frank Sch?fer <fschaefer.oss@googlemail.com>
> Cc: Dinh Nguyen <dinh.linux@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c     | 11 ++++++++++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  9 +--------
>  2 files changed, 11 insertions(+), 9 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
