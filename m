From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Jun 2017 18:49:15 +0200
Subject: [PATCH v2 01/11] dt-bindings: update the binding for Allwinner
 H3 TVE support
In-Reply-To: <092D4797-0034-4C39-A30A-92CFAB23AAF8@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-2-icenowy@aosc.io>
 <20170607084544.kgclybyxxttfk3ko@flea.lan>
 <092D4797-0034-4C39-A30A-92CFAB23AAF8@aosc.io>
Message-ID: <20170609164915.enap3epreg5vr2gy@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 04:48:50PM +0800, Icenowy Zheng wrote:
> >> @@ -189,6 +211,8 @@ supported.
> >>  Required properties:
> >>    - compatible: value must be one of:
> >>      * allwinner,sun8i-v3s-de2-mixer
> >> +    * allwinner,sun8i-h3-de2-mixer0
> >> +    * allwinner,sun8i-h3-de2-mixer1
> >
> >Again, please explain why we need to have different compatibles
> >here. If it's only about the number of planes, this should be dealt
> >with a property, not a compatible.
> 
> Only mixer0 has "VEP" and write-back support, at least on H3.

What is that VEP? writeback support can also be expressed by a
property.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/33af4316/attachment.sig>
