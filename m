From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 15:22:56 +0200
Subject: [GIT PULL] i.MX features
In-Reply-To: <20111014074747.GD13898@pengutronix.de>
References: <20111014074747.GD13898@pengutronix.de>
Message-ID: <201110201522.56223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 October 2011, Sascha Hauer wrote:
> Hi Arnd,
> 
> Please pull the following feature branch for i.MX.
> 
> Only trivial merge conflicts to your for-next branch, you won't need
> a merge hint for this, I created a branch for you anyway just to
> see if that's what you want for the next non trivial merge conflicts:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git hint

Ok, sounds good.
 
> The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:
> 
>   Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-for-arnd

I've pulled it all into the imx/devel branch now, but I've also pulled
the two parts of it into separate branches. I already have a next/board
branch that contains support for new boards and now has the DENX MX28
commit added to it as well. I've put the AHCI changes into the next/driver
branch that was suggested before. I still need to decide whether I
submit that separately before the next/devel branch or if I drop it
again (most likely if I don't get much stuff for it).

Thanks,

	Arnd
