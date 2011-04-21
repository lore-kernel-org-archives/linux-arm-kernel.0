From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 21 Apr 2011 10:21:06 -0700
Subject: [GIT PULL] Please pull ASoC's tegra branch into Tegra for-next
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04973BB857@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin, Erik, Olof,

Please pull

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git tegra

into Tegra's for-next, or whichever branch is appropriate for 2.6.40 work.

This will bring in:

47912a6 ARM: Tegra: select MACH_HAS_SND_SOC_TEGRA_WM8903
61a6d07 ARM: Tegra: Add to tegra_wm8903_platform_data
7b33af2 ASoC: Tegra: Rename pdev tegra-snd-harmony to tegra-snd-wm8903
4651d55 ARM: Tegra: Rename harmony_audio.h -> tegra_wm8903_pdata.h
a6360dd Linux 2.6.39-rc3

The changes are required to add Seaboard audio support into the Tegra
branch. I'll post patches for that later today.

I have tested that:

* The merge has no conflicts.
* The merge result compiles.
* The resultant kernel runs OK on Harmony.
* With the addition of the patch below, which is required to fix an
  already-extant bug in Tegra's for-next branch, and which I'll repost
  later today, audio on Harmony works fully.
  ARM: Tegra: Harmony: Fix conflicting GPIO numbering

Thank you.

-- 
nvpublic
