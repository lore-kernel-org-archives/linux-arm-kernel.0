From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue, 11 Jan 2011 09:38:57 +0100
Subject: Change SUEN3 MACH to KM_KIRKWOOD
In-Reply-To: <4D2C1595.50705@keymile.com>
References: <4D2C1595.50705@keymile.com>
Message-ID: <4D2C1721.3040000@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry I made a typo in the subject of the previous mail.

To avoid any confusion, the desired name definitely is KM_KIRKWOOD (and 
not KMKIRKWOOD as written in the subject of the previous mail).

Valentin Longchamp wrote:
> Hello Russel,
> 
> Denx developper Stefan Roese had registered the MACH_SUEN3 with number 
> 2255 when they had ported u-boot for our SUEN3 board.
> 
> Our company now has developped several boards with the same architecture 
> (and thus share quite a lot of code) and the MACH_SUEN3 really is board 
> specific and while it should define something generic. We have 
> disscussed with Stefan and have agreed that the best would be to keep 
> this MACH number but to change its name to something that is common to 
> all the boards and thus more logical for us.
> 
> Could you please change the MACH_SUEN3 (and all the corresponding suen3 
> occurences) to MACH_KM_KIRKWOOD (respectively km_kirkwood) in the 
> arch/arm/tools/mach-types file and the corresponding database ?
> 
> Thanks and best regards
> 
