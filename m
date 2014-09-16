From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Tue, 16 Sep 2014 11:08:19 +0300
Subject: [PATCH v3 0/4] Add Phytec pbab01 audio support
In-Reply-To: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New phyFLEX board audio patchset version.

Defines from dt-bindings/sound/fsl-imx-audmux.h are now used in audmux
configuration instead of hardcoded register values.

Also patchset is now based on branch for-next from
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git which
means:

- removed #sound-dai-cells in ssi2 node since it was already moved to
  imx6qdl.dtsi;
- patch for imx_v6_v7_defconfig now enables only
  CONFIG_SND_SOC_TLV320AIC3X since CONFIG_SND_SIMPLE_CARD also was
  already enabled.
