From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 15 May 2018 09:09:01 +1000
Subject: linux-next: manual merge of the samsung-krzk tree with the
 dma-mapping tree
In-Reply-To: <20180510091634.7fb3aaf2@canb.auug.org.au>
References: <20180510091634.7fb3aaf2@canb.auug.org.au>
Message-ID: <20180515090901.74c9429e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, 10 May 2018 09:16:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
> 
>   arch/arm/mach-exynos/Kconfig
> 
> between commit:
> 
>   4965a68780c5 ("arch: define the ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig")
> 
> from the dma-mapping tree and commit:
> 
>   c5deb598089c ("ARM: exynos: Remove support for Exynos5440")
> 
> from the samsung-krzk tree.
> 
> I fixed it up (the latter removed the whole section modified by
> the former, so I just removed the section) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and the dma-mapping tree.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/e2b00e44/attachment.sig>
