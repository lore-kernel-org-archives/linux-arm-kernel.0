From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Sep 2015 08:33:37 +0200
Subject: [linux-sunxi] [PATCH v2 2/4] ARM: dts: sun4i: gemei-g9: Convert
 to use axp209 regulator nodes
In-Reply-To: <CAGRGNgVLV_hSSTEPuC2_ga6H=wHNFuOktvCE2Mvk_txg8zCLgQ@mail.gmail.com>
References: <1442993914-20295-1-git-send-email-plaes@plaes.org>
 <1442993914-20295-3-git-send-email-plaes@plaes.org>
 <CAGRGNgVLV_hSSTEPuC2_ga6H=wHNFuOktvCE2Mvk_txg8zCLgQ@mail.gmail.com>
Message-ID: <20150925063337.GY4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 09:42:33AM +1000, Julian Calaby wrote:
> Hi Priit,
> 
> On Wed, Sep 23, 2015 at 5:38 PM, Priit Laes <plaes@plaes.org> wrote:
> > Add regulator nodes for axp209 by including the axp209 dtsi.
> >
> > Changes in v2:
> >  - Add the ohci0 node.
> 
> Firstly, changelog stuff like this should be below the --- under your SOB.
> 
> Also, shouldn't enabling the ohci0 node be a separate patch?

It should.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/7f56394c/attachment.sig>
