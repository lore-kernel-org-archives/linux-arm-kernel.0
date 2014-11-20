From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 10:27:22 +0100
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
In-Reply-To: <546298D9.7080800@hauke-m.de>
References: <546298D9.7080800@hauke-m.de>
Message-ID: <201411201027.22360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Hauke Mehrtens wrote:
> ----------------------------------------------------------------
> ARM: BCM5301X: SoC: two patches for the SoC part
> 
> These patches were all send to the arm list and I haven't got any
> negative responses.
> 
> ----------------------------------------------------------------
> Hauke Mehrtens (1):
>       ARM: BCM5301X: fix early serial console
> 
> Rafa? Mi?ecki (1):
>       ARM: BCM5301X: select GPIOLIB as optional

Hi Hauke and Florian,

sorry for the late reply. The patches are both good and I want to merge them,
but I have two problems with your pull request:

- I'm unsure about who is sending us patches for mach-bcm. I was under the
  assumption that Florian would now handle all of them and pick up your
  patches to forward them to arm at kernel.org together with the other mach-bcm
  platforms. I'd much rather get only patches from one person per platform
  directory, though we can have multiple people if that's what you all want.

- The pull request is based on -rc4, but I see no strong reason why you did
  that. It helps us a lot of all pull requests in a branch are based off
  the same -rc, so please have them based on -rc1 by default or explain why
  you picked something else in the tag description.

If you want, I can just cherry-pick the two patches from your branch into
the next/soc branch so you don't have to rebase it this time.

	Arnd
