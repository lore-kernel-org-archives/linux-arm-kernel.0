From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 4 Aug 2011 20:00:14 +0530
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <CACRpkdZ12S8qC_5VbV2d3BpCtZQpR5U9OHyxMR61bo92L83WLw@mail.gmail.com>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
	<20110802160234.GH19079@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
	<CACRpkdZ12S8qC_5VbV2d3BpCtZQpR5U9OHyxMR61bo92L83WLw@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DF06447@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 04:18:49, Linus Walleij wrote:
> On Wed, Aug 3, 2011 at 7:19 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
> 
> > This isn't the only thing that prevents building the TNET variant
> > with the rest of the DaVinci variants.
> >
> > If you enable DM365 and TNETV107x together, you get errors:
> 
> Looks like it needs some KConfig patch to disallow such combinations
> then?

Yes, need to work on this. Build breakage is bad.

Thanks,
Sekhar
