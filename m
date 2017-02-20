From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Feb 2017 14:58:25 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: Document Marvell
 IAP140
In-Reply-To: <cac4ed13-5952-cccc-fee7-d9c29e77d8bb@suse.de>
References: <20170219032000.4674-1-afaerber@suse.de>
 <20170219032000.4674-3-afaerber@suse.de>
 <20170220135646.2b0219c1@free-electrons.com>
 <cac4ed13-5952-cccc-fee7-d9c29e77d8bb@suse.de>
Message-ID: <20170220145825.5f7cbe74@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 20 Feb 2017 14:16:13 +0100, Andreas F?rber wrote:

> I'm confused now. According to Marvell IR [0] they are NASDAQ-listed as
> MRVL. My understanding is that in that case the official vendor prefix
> becomes mrvl. Why not here?

Not sure why, but as of today, we have a mix of "mrvl" and "marvell" in
the tree, and "marvell" is the one official listed in
vendor-prefixes.txt.

> Any comments on the iap140 vs. pxa1908 naming? The Communication
> Processors section has disappeared from marvell.com, so I couldn't
> verify whether IAP140 was renamed from PXA1908 or whether both coexist
> and we should add a second compatible string here?

I don't have an opinion on this because I'm not familiar with this
family of Marvell SoCs. However, the only thing I would recommend is
that you send a patch to update Documentation/arm/Marvell/README to
document this PXA1908/IAP140 thing. This is particularly important
since this document mentions PXA1908 already.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
