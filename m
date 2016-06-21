From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 10:56:21 +0200
Subject: linux-next: manual merge of the net-next tree with the arm-soc
 tree
In-Reply-To: <20160621111839.34936836@canb.auug.org.au>
References: <20160621111839.34936836@canb.auug.org.au>
Message-ID: <4384645.F021K1OoaK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 11:18:39 AM CEST Stephen Rothwell wrote:
> Today's linux-next merge of the net-next tree got conflicts in:
> 
>   arch/arm64/boot/dts/broadcom/ns2-svk.dts
>   arch/arm64/boot/dts/broadcom/ns2.dtsi
> 
> between commits:
> 
>   97b1504a30b3 ("arm64: dts: enable pinctrl for Broadcom NS2 SoC")
>   5dcc9c7618df ("arm64: dts: NS2: Add CCI-400 PMU support")
> 
> from the arm-soc tree and commit:
> 
>   5f1a067bfa0a ("dt: mdio-mux: Add mdio multiplexer driver node")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me, thanks!

I don't see a good way to resolve the conflict before the merge window,
but it's simple enough that we can just send it this way and let
Linus handle it.

	Arnd
