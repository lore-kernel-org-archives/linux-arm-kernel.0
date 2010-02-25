From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 20:51:13 +0000
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
Message-ID: <20100225205113.GF3101@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 10:49:03AM +0800, Eric Miao wrote:
> Russell,
> 
> Please help pull from below, thanks.
> 
> The following changes since commit 724e6d3fe8003c3f60bf404bf22e4e331327c596:
>   Linus Torvalds (1):
>         Linux 2.6.33-rc8
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Err, you've rebased your tree since I last pulled it, and this now results
in the following, and a load of duplicated commits between the two trees.

This is not nice, please don't rebase stuff which I've already pulled.

I'm going to think about what to do about this; I can't trivially drop
your previous work from my tree.

diff --cc arch/arm/mach-pxa/raumfeld.c
index 06717d7,3184bdc..0000000
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@@ -231,6 -231,10 +231,13 @@@ static mfp_cfg_t raumfeld_connector_pin
  	GPIO26_SSP2_FRM,
  	GPIO27_SSP2_TXD,
  	GPIO29_SSP2_EXTCLK,
++<<<<<<< HEAD:arch/arm/mach-pxa/raumfeld.c
++=======
+ 
+ 	/* LEDs */
+ 	GPIO35_GPIO | MFP_LPM_PULL_LOW,
+ 	GPIO36_GPIO | MFP_LPM_DRIVE_HIGH,
++>>>>>>> aa4efff73f7ccf59efbc1fc98c31b43b70dc3731:arch/arm/mach-pxa/raumfeld.c
  };
  
  static mfp_cfg_t raumfeld_speaker_pin_config[] __initdata = {
@@@ -277,6 -281,10 +284,13 @@@
  	GPIO87_SSP1_TXD,
  	GPIO88_SSP1_RXD,
  	GPIO90_SSP1_SYSCLK,
++<<<<<<< HEAD:arch/arm/mach-pxa/raumfeld.c
++=======
+ 
+ 	/* LEDs */
+ 	GPIO35_GPIO | MFP_LPM_PULL_LOW,
+ 	GPIO36_GPIO | MFP_LPM_DRIVE_HIGH,
++>>>>>>> aa4efff73f7ccf59efbc1fc98c31b43b70dc3731:arch/arm/mach-pxa/raumfeld.c
  };
  
  /*
