From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Oct 2012 07:41:37 -0700
Subject: [PATCH 4/4] mtd: nand: omap2: Add data correction support
In-Reply-To: <20121011082149.GA15609@parrot.com>
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
 <1349274589-11389-5-git-send-email-avinashphilip@ti.com>
 <20121003192044.GB27502@parrot.com>
 <518397C60809E147AF5323E0420B992E3E9B8A65@DBDE01.ent.ti.com>
 <20121005142338.GA7199@parrot.com>
 <518397C60809E147AF5323E0420B992E3E9CA829@DBDE01.ent.ti.com>
 <20121010170806.GB13585@parrot.com>
 <518397C60809E147AF5323E0420B992E3E9CB751@DBDE01.ent.ti.com>
 <20121011082149.GA15609@parrot.com>
Message-ID: <20121011144137.GA12552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivan Djelic <ivan.djelic@parrot.com> [121011 01:23]:
> 
> I don't know which way is better for the OMAP community:
> 1. Unifying ECC modes = loosing the constant polynomial benefits, but gaining RBL compat and simplifying code
> 2. Keeping separate ECC modes = code bloat
> 
> Tony, do you have an opinion on this ?

Well right now I'm mostly interested in making device
drivers independent of the arch/arm/*omap*/* code.
That's where Afzal's patches help quite a bit, so let's
get those in first. So from that point of view, option #1
above sounds better as the first step :)

Ideally of course option #1 should not limit us from
adding extra features in the long run.

Regards,

Tony 
