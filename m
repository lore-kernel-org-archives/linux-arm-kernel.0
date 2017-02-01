From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 01 Feb 2017 16:54:08 +0100
Subject: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
In-Reply-To: <20170201150252.gvoqp3eprj5bosvu@rob-hp-laptop>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-2-git-send-email-kraxel@redhat.com>
 <20170201150252.gvoqp3eprj5bosvu@rob-hp-laptop>
Message-ID: <1485964448.1076.68.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt

> > +Example:
> > +
> > +sdhost: sdhost at 7e202000 {
> 
> Node names should be the generic type of device, so:
> 
> mmc at ...

Ok, done.

I guess arch/arm/boot/dts/bcm283x.dtsi should get the same update?

cheers,
  Gerd
