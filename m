From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Sep 2016 12:22:59 -0700
Subject: [PATCH v4 5/8] ARM: dts: am335x-boneblack: Add
 blue-and-red-wiring -property to LCDC node
In-Reply-To: <d9dcc43b-6884-aab1-ff82-c66ecf6e96b6@ti.com>
References: <cover.1472719892.git.jsarha@ti.com>
 <fad833a6a4368196f4fc131a54d90f5b90169393.1472719892.git.jsarha@ti.com>
 <d9dcc43b-6884-aab1-ff82-c66ecf6e96b6@ti.com>
Message-ID: <20160915192257.hbz4vqxgd5thesfq@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jyri Sarha <jsarha@ti.com> [160915 02:44]:
> Tony,
> The functional changes are now merged. But let's not merge this bbb dts
> patch just yet, so we do not cause a conflict with the other bbb hdmi
> audio dts change[1] that slipped into tda998x pull request. The patch
> can very well wait until v4.10 if needed.
> 
> However, the other three dts patches[2] can be merged. Should I rebase
> those on top of some branch and resend them?

Sorry I've lost count of all the patches and about tag all my emails
as read for v4.9 merge window. So yeah it's best to resend the dts
changes separately :)

Regards,

Tony
