From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:21 -0700
Subject: [GIT PULL 0/7] ARM: SoC changes for v4.8
Message-ID: <1470087568-4222-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's our set of branches for this release. As usual, each pull request describes
the conflicts that will show up and brief descriptions on how to resolve. I've
also pushed a sample-merge branch to the repo to compare final results with.

When it comes to contents, this is a release cycle that's on the small
side for us at "only" 858 patches merged that haven't already gone in
through other trees.

New platforms for this cycle are:

32-bit:
 - Broadcom BCM23550
 - Freescale i.MX7Solo
 - Qualcomm MDM9615
 - Renesas r8a7792

64-bit:
 - Broadcom BCM2837
 - Renesas r8a7796

Out of those, BCM2837 might be worth pointing out since it is the SoC
used on Raspberry Pi 3, so it's great to start seeing support there.

As contributors go, the top 15 authors of patches are:

Geert Uytterhoeven (73)
Krzysztof Kozlowski (41)
Javier Martinez Canillas (36)
Ben Dooks (33)
Hans de Goede (33)
Alexandre Belloni (29)
Arnd Bergmann (25)
Chen-Yu Tsai (23)
Srinivas Kandagatla (21)
Thierry Reding (20)
Jon Hunter (19)
Andy Gross (18)
Alexander Shiyan (17)
Florian Fainelli (17)
Sergei Shtylyov (17)

And dirstat speaks pretty clearly about where the bulk of changes are for us
now: 32-bit device-tree contents. 64-bit platforms are slowly picking up but
have nowhere near the rate of change:

  61.8% arch/arm/boot/dts/
   4.3% arch/arm/mach-ux500/
   8.0% arch/arm/
   9.2% arch/arm64/boot/dts/
  11.4% drivers/

Driver stand out this release cycle in part due to an active time for reset
driver conversions, and that tree is normally merged through us.


Please merge!

Thanks,

Olof (and Arnd and Kevin)
