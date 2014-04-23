From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 23 Apr 2014 12:17:34 -0300
Subject: [PATCH RFC] ARM: dts: am335x: update USB DT references
In-Reply-To: <20140423144822.GA4833@atomide.com>
References: <1397647595-10927-1-git-send-email-leigh@solinno.co.uk>
 <5356794C.7070707@baylibre.com> <20140423144822.GA4833@atomide.com>
Message-ID: <20140423151734.GA5867@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 23, Tony Lindgren wrote:
> * Benoit Cousson <bcousson@baylibre.com> [140422 07:14]:
> > Hi Leigh,
> > 
> > On 16/04/2014 13:26, Leigh Brown wrote:
> > >In "ARM: dts: am33xx: correcting dt node unit address for usb", the
> > >usb_ctrl_mod and cppi41dma nodes were updated with the correct register
> > >addresses.  However, the dts files that reference these nodes were not
> > >updated, and those devices are no longer being enabled.
> > >
> > >This patch corrects the references for the affected dts files.

Maybe someone can take care of using phandles instead?

This way, the board's dts files would be immune to such .dtsi changes.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
