From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 15:57:25 +0100
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
Message-ID: <6044873.2S2Xlhp0hC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 14:53:48 Phil.Edworthy at renesas.com wrote:
> 
> > > +      reg = <0 0xfe000000 0 0x80000>;
> > > +      #address-cells = >;
> > > +      #size-cells = <2>;
> > > +      device_type = "pci";
> > 
> >     This legacy property is only meaningful for the true OF firmware and 
> thus 
> > have been phased out (it's only actively used for the memory nodes).
> Ok, thanks for pointing this out.
> 

I think the code still relies on it for PCI though.

	Arnd
