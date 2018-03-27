From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 27 Mar 2018 15:55:22 +0800
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
In-Reply-To: <20180327091026.3facbb9d@canb.auug.org.au>
References: <20180327091026.3facbb9d@canb.auug.org.au>
Message-ID: <20180327075520.GA3245@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 09:10:26AM +1100, Stephen Rothwell wrote:
> Hi Shawn,
> 
> Today's linux-next merge of the imx-mxs tree got a conflict in:
> 
>   arch/arm/configs/mxs_defconfig
> 
> between commit:
> 
>   e3e583e7a293 ("ARM: mxs_defconfig: Re-sync defconfig")
> 
> from the arm-soc tree and commit:
> 
>   8bc2c29b550c ("ARM: mxs_defconfig: Re-sync defconfig")
> 
> from the imx-mxs tree.
> 
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, Stephen.  We will sort this out on arm-soc tree.

Arnd,

You pulled "[GIT PULL 6/6] i.MX defconfig updates for 4.17" [1]?
I thought you did not pull it, and updated it with v2 to address your
comment.  Let me know which one you want to send upstream.  Thanks.

Shawn

[1] https://patchwork.ozlabs.org/patch/886191/
