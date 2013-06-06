From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Jun 2013 22:22:53 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <20130606172810.GE14209@lukather>
References: <51AFA6DD.3000202@wwwdotorg.org>
 <CAOesGMgqxhG45NyCfpHc_0uHS+_Gn-hGZm-+CRvK2EEf1AGTow@mail.gmail.com>
 <20130606172810.GE14209@lukather>
Message-ID: <201306062222.53780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 June 2013, Maxime Ripard wrote:
> So yes, Allwinner has an evil vendor tree (c), with a solution similar yet
> inferior (because not generic enough) to the device tree, but they show
> interest on going down the mainline road.

Right, and of course there is nothing special about that, everybody starts
out with they own even vendor tree (c), and as hardware support gets merged
upstream, the diff gets smaller, even though the code in the mainline
kernel is normally very different from what they started out with.

Chances are actually that the Allwinner (A10/A13/A20, not A31) platform may
end up being the first modern one that is fully supported upstream including
a GPU driver, since it is one of the obvious targets for the
reverse-engineering efforts. Ironically (given NVIDIA's reputation), the
Tegra platform is the strongest competitor I see in that race at the moment.

For all I can tell, things are progressing nicely, given that it's currently
a volunteer effort. If anyone needs things to move faster, I'd recommend
them to send money to free-electrons.com.

	Arnd
