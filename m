From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 4 Sep 2013 13:33:21 +0300
Subject: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver for Vybrid
 VF610 platform
In-Reply-To: <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
 <81BA6E5E0BC2344391CABCEE22D1B6D83F448E@039-SN1MPN1-002.039d.mgd.msft.net>
 <81BA6E5E0BC2344391CABCEE22D1B6D8403CB3@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <52270C71.7080805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/09/13 11:21, Wang Huan-B18965 wrote:
> Hi, Jean-Christophe, Tomi,
> 
>       Could you please help to review these patches?
>       Thanks!

There seemed to be some strong opinions that there should be a drm
driver for this hardware, instead of an fb driver. So as there seems to
be disagreements about this, I'll leave this series to Jean-Christophe,
who's the primary maintainer.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/90321e33/attachment.sig>
