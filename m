From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 15:09:31 +0200
Subject: [PATCH 1/3] dt: Add DT bindings documentation for SUNXI Security
 System
In-Reply-To: <201405242159.30505.marex@denx.de>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <201405242143.42693.marex@denx.de> <5380F85F.7020601@gmail.com>
 <201405242159.30505.marex@denx.de>
Message-ID: <20140525130931.GI10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 09:59:30PM +0200, Marek Vasut wrote:
> On Saturday, May 24, 2014 at 09:51:59 PM, Tomasz Figa wrote:
> [...]
> > >>> Why sun7i-a20 ? Is the crypto unit different in other sunxi chips ? Can
> > >>> that not be described by DT props ?
> > >> 
> > >> A widely used convention is to define compatible strings after first
> > >> SoCs on which particular IP blocks appear. It is quite common among IP
> > >> blocks for which there is no well defined versioning scheme.
> > > 
> > > Well yeah, that's fine. But in this case, "sun7i" is the entire group of
> > > CPUs manufactured by AW. I find that information redundant, the
> > > "allwinner,a20- crypto" would suffice. But I wonder if that IP block
> > > might have appeared even earlier ? Or if it is CPU family specific, thus
> > > "allwinner,sun7i-crypto" would be a better string ?
> > 
> > I'm not aware of Allwinner naming schemes too much, so please correct me
> > if I'm wrong, but if A20 implies sun7i, then "allwinner,a20-crypto"
> > would be better indeed.
> 
> True.
> 
> > Whether it was really the first SoC is another thing. Obviously this
> > needs to be checked, although it isn't really that important. For this
> > particular naming scheme you need to specify all the SoCs for which
> > given compatible string can be used for this IP anyway, because there is
> > usually no other source of information about this available (except
> > directly comparing two datasheets...).
> 
> Better get the DT stuff correctly right from the start. That's why I'm asking 
> what chips contains the IP block, so we can guess the right name.

The name is fine, please stop this bikeshedding.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/20612c5e/attachment.sig>
