From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Aug 2015 16:48:34 +0200
Subject: [GIT PULL 3/9] ARM: tegra: Cleanup patches for v4.3-rc1
In-Reply-To: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1439563720-13189-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-cleanup

for you to fetch changes up to 5cf4af3bebb718b72a23b7e80fddfe8b4e8b0620:

  ALSA: hda/tegra: Order clock and reset names consistently (2015-07-16 09:42:05 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Cleanup patches for v4.3-rc1

Just a couple of trivial cleanups to make the HDA controller driver code
match the device tree binding.

----------------------------------------------------------------
Marcel Ziswiler (1):
      ALSA: hda/tegra - Fix hda2codec_2x clock and reset names

Thierry Reding (1):
      ALSA: hda/tegra: Order clock and reset names consistently

 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
