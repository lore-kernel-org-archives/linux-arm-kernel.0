From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 23 May 2012 01:35:12 +0000
Subject: [PATCH v2 02/12] usb: chipidea: permit driver bindings pass phy
 pointer
In-Reply-To: <20120522151425.GB2380@richard-laptop>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-3-git-send-email-richard.zhao@freescale.com>
 <87ehqcbko0.fsf@ashishki-desk.ger.corp.intel.com>
 <201205221607.31624.marex@denx.de> <20120522151425.GB2380@richard-laptop>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BB38BF@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Finally, we'll get phy instance from phy lib. But I don't know when it
> is ready. So I add this code for handy use before phy lib.
> 
not phy lib, but phy driver. lib is different with driver.

> For now, it's ok. When I register platform device, it dup the plat data
> memory.
> 
> Thanks
> Richard
> >
> > >
> > > Regards,
> > > --
> > > Alex
> >
> > Best regards,
> > Marek Vasut
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
