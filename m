From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 03:32:24 -0700
Subject: [GIT PULL] omap n900 regression fix for v3.16 rc series
Message-ID: <20140729103223.GK29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 33753cd2ba41c72a0756edc5dc094d91602deda5:

  ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable() (2014-07-23 01:48:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/n900-regression

for you to fetch changes up to d937678ab625b0f63ce54b2b9b3e1cbd1b4a1b15:

  ARM: dts: Revert enabling of twl configuration for n900 (2014-07-29 00:16:25 -0700)

----------------------------------------------------------------
Minimal regression fix for n900 display that got broken with
enabling of twl4030 PM features. Turns out more work is needed
before we can enable twl4030 PM on n900.

I did not notice this earlier as I have my n900 in a rack
and the display did not get enabled for device tree based booting
until for v3.16.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: dts: Revert enabling of twl configuration for n900

 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
