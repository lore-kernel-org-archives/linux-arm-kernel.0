From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Oct 2016 16:55:44 +0200
Subject: [PATCH 0/7] constify snd_soc_ops structures
Message-ID: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify snd_soc_ops structures.

---

 sound/soc/atmel/atmel_wm8904.c                  |    2 +-
 sound/soc/fsl/fsl-asoc-card.c                   |    2 +-
 sound/soc/fsl/imx-wm8962.c                      |    2 +-
 sound/soc/generic/simple-card.c                 |    2 +-
 sound/soc/generic/simple-scu-card.c             |    2 +-
 sound/soc/intel/boards/bdw-rt5677.c             |    2 +-
 sound/soc/intel/boards/broadwell.c              |    2 +-
 sound/soc/intel/boards/bxt_da7219_max98357a.c   |    4 ++--
 sound/soc/intel/boards/bxt_rt298.c              |    4 ++--
 sound/soc/intel/boards/bytcr_rt5640.c           |    4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c           |    4 ++--
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    |    4 ++--
 sound/soc/intel/boards/cht_bsw_rt5645.c         |    4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c         |    4 ++--
 sound/soc/intel/boards/haswell.c                |    2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c |    6 +++---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |    6 +++---
 sound/soc/intel/boards/skl_rt286.c              |    4 ++--
 sound/soc/kirkwood/armada-370-db.c              |    2 +-
 sound/soc/mxs/mxs-sgtl5000.c                    |    2 +-
 sound/soc/qcom/storm.c                          |    2 +-
 sound/soc/rockchip/rk3399_gru_sound.c           |    6 +++---
 sound/soc/rockchip/rockchip_max98090.c          |    2 +-
 sound/soc/rockchip/rockchip_rt5645.c            |    2 +-
 sound/soc/tegra/tegra_alc5632.c                 |    2 +-
 sound/soc/tegra/tegra_max98090.c                |    2 +-
 sound/soc/tegra/tegra_rt5640.c                  |    2 +-
 sound/soc/tegra/tegra_rt5677.c                  |    2 +-
 sound/soc/tegra/tegra_sgtl5000.c                |    2 +-
 sound/soc/tegra/tegra_wm8753.c                  |    2 +-
 sound/soc/tegra/tegra_wm8903.c                  |    2 +-
 sound/soc/tegra/trimslice.c                     |    2 +-
 32 files changed, 46 insertions(+), 46 deletions(-)
