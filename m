From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 14:53:40 +0200
Subject: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
In-Reply-To: <504DD128.1000803@ti.com>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch>
 <20120906205227.GM1303@atomide.com> <504DB202.5050500@epfl.ch>
 <504DD128.1000803@ti.com>
Message-ID: <504DE2D4.8030705@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Patches looks good to me. I just adding them right now in my for_3.7/dts tree.
>
> I've just slightly changed the subjects:
>
> Documentation: dt: Update the OMAP documentation with Overo/Toby
> ARM: dts: OMAP3: Add support for Gumstix Overo with Tobi expansion board
>
> If you want to give it a try, here is the branch that contains all the DTS series I
> already pulled. It includes your gpio-twl4030 patches as well.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.7/dts

Boot as expected on Gumstix Overo with Tobi expansion board.

I will submit a patch to support the blue LED connected to the TWL4030, 
as the DTS support was merged in your branch.

And of course I will continue on getting features to work with 
devicetree for the Overo.

Regards,
Florian
