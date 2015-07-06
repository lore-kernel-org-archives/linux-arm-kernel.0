From: mars.cheng@mediatek.com (Mars Cheng)
Date: Mon, 6 Jul 2015 08:53:15 +0800
Subject: [PATCH v2 2/2] ARM: dts: mediatek: add 6580 support
In-Reply-To: <1665353.lNSALdu3Cy@ubix>
References: <1435647751-20422-1-git-send-email-mars.cheng@mediatek.com>
 <1435647751-20422-3-git-send-email-mars.cheng@mediatek.com>
 <1665353.lNSALdu3Cy@ubix>
Message-ID: <1436143995.15570.2.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Change-Id: Ic5c93eb5d1e6e23503dabd28d41c30a7f02e9c18
> 
> Please delete the change-id.

> > +	uart0: serial at 11005000 {
> > +		compatible = "mediatek,mt6580-uart",
> > +			     "mediatek,mt6577-uart";
> 
> Please update the dts documentation about the compatible string.
> Apart from that it looks fine for me.
> 
I will fix these two and send another patch soon.

Thanks for comments.

> Cheers,
> Matthias
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
