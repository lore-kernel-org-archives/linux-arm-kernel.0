From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Oct 2013 15:23:08 -0700
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <CAHCPf3tt8sbXnABUomg_w1ttBTgBQL=VNwsRoFazzuVdgzzO=g@mail.gmail.com>
References: <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
 <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
 <20131031174549.GG2493@sirena.org.uk>
 <CAHCPf3tt8sbXnABUomg_w1ttBTgBQL=VNwsRoFazzuVdgzzO=g@mail.gmail.com>
Message-ID: <20131031222308.GL2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 04:19:05PM -0500, Matt Sealey wrote:

> Yes, I can make a big list and even send a patch, but I think it's
> putting a band-aid on a non-surgical limb amputation.

It would be moving the situation forwards which is something that
lengthy e-mails full of architecting with zero code won't do. 

> > To repeat myself yet again: what is done to the CODEC here is system
> > dependent.  This includes interaction with other components in the
> > system.

> In this particular use case (init setting sysclk, and bias_level
> callbacks setting sysclk and pll for WM8962), there is no system
> dependency except a fixed, unchanging parent clock (it's fixed at card
> init and NEVER updated) which the DT binding can solve really easily

That is the chosen configuration for the systems you are looking at;
other systems do exist.  This is the nature of board specifics.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/b23d31b1/attachment.sig>
