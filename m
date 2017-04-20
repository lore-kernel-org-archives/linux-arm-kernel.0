From: Nicolas.Ferre@microchip.com (Nicolas.Ferre at microchip.com)
Date: Thu, 20 Apr 2017 14:50:57 +0000
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
In-Reply-To: <20170420083817.5a44b69c@canb.auug.org.au>
References: <20170420083817.5a44b69c@canb.auug.org.au>
Message-ID: <56448E9475A7CD4F97A754616F76B45780C65F@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Nicolas,
>
> Today's linux-next merge of the at91 tree got a conflict in:
> 
>  arch/arm/boot/dts/at91-tse850-3.dts
> between commit:
>
> e67cedc92812 ("ARM: dts: at91: add envelope detector mux to the Axentia TSE-850")
>
> from the arm-soc tree and commit:
>
>  29dd89418007 ("ARM: dts: at91: add envelope detector mux to the Axentia TSE-850")
>
> from the at91 tree.
>
> I fixed it up (I used the arm-soc tree version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Stephen,

Yes, the use of arm-soc version was the way to go. I now have updated my at91-next tree to match Alexandre's pull-request and hope it is not in conflict anymore.

Thanks for your fix.
Best regards,
