From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 Dec 2011 09:32:36 +0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20111219105548.d30839e148800b38bc93d001@canb.auug.org.au>
References: <20111219105548.d30839e148800b38bc93d001@canb.auug.org.au>
Message-ID: <20111219013235.GA4962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 10:55:48AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
Hi Stephen,

> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-imx/mach-imx6q.c between commit 1237f0f6ecf6 ("ARM: 7198/1:
> arm/imx6: add restart support for imx6q") from the arm tree and commit
> 477fce49aef4 ("arm/imx6q-sabrelite: add enet phy ksz9021rn fixup") from
> the arm-soc tree.
> 
> Just context changes.  I fixed it up (see below) and can carry the fix as
> necessary.

It looks all right.  Thanks.

-- 
Regards,
Shawn
