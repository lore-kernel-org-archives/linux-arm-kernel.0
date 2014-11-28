From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 15:05:58 +0100
Subject: [GIT PULL] Allwinner SimpleFB support for 3.19
In-Reply-To: <20141123163554.GA5788@lukather>
References: <20141123163554.GA5788@lukather>
Message-ID: <201411281505.58352.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following patches that enable simplefb on most of the
> Allwinner SoCs, allowing to finaly be able to have support for a video
> display using simplefb as a temp solution.
> 
> Thanks,
> Maxime
> 
> The following changes since commit 109588fd214c930ce6561997250f0eea456a8f7b:
> 
>   ARM: dts: sun6i: Add ethernet support to M9 board (2014-11-23 17:00:25 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-simplefb-for-3.19
> 
> for you to fetch changes up to a9f8cda32a3acc3150755fe973f7fa1867a7a5d6:
> 
>   ARM: dts: sunxi: Update simplefb nodes so that u-boot can find them (2014-11-23 17:21:52 +0100)
> 
> ----------------------------------------------------------------
> Allwinner simple frambuffer support
> 
> This enables the simple framebuffer on all the supported Allwinner SoCs (but
> the A80). That allows to have at last a video display usable by using the
> framebuffer the firmware might have set up.
> 

Pulled into next/dt. I'm glad you finally reached a consensus on this. I
never followed the discussion but saw the hundreds of mails fly by on the
topic.

	Arnd
