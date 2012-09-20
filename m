From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 20 Sep 2012 15:24:34 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <alpine.DEB.2.02.1209201501140.29232@kaball.uk.xensource.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1209201240110.29232@kaball.uk.xensource.com>
 <1348143533.26501.28.camel@zakaz.uk.xensource.com>
 <201209201327.45802.arnd@arndb.de>
 <alpine.DEB.2.02.1209201501140.29232@kaball.uk.xensource.com>
Message-ID: <1348151074.11116.126.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 15:11 +0100, Stefano Stabellini wrote:
> On Thu, 20 Sep 2012, Arnd Bergmann wrote:
> > It's not much different in the end, but I think I'd rather make the
> > compatible list in the device tree "xen,xenvm-4.2", "xen,xenvm" without
> > listing "arm,vexpress", but then adding "xen,xenvm" to the list of
> > compatible devices in the vexpress kernel code.
>
> That's a very good idea, I'll do that.

Yep, this would work with me as well. And I'm sure we can make the
"arm,vexpress,memory-map" bit unnecessary as well - have a look into it,
and I'll help you as much as I can.

And then, if your "reference" DTS is to be merged, it won't be called
vexpress-*.dts, so I will not have to decide whether to take it in or
not :-)

Cheers!

Pawe?
