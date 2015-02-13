From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Feb 2015 18:12:22 +0200
Subject: [PATCHv2 00/33] ARM: OMAP2+: PRCM/omap ctrl cleanups against 3.19-rc1
Message-ID: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Updates since v1:

- fixed omap2/am33xx boot issues
- added regmap support to generic omap clock core
- control module driver converted to use syscon
- dropped patches for removing legacy pad muxing support (this is still
  needed)

Notes:

- patches 4,5 and 8 not posted as these were already queued by Tony
- the above patches still exist in the test branch though
- patches 22-33 are new

Testing done:
- am335x-evm: boot
- am335x-sk: boot
- am3517-evm: boot
- am43x-epos-evm: boot
- am437x-gp-evm: boot
- omap3-beagle-xm: boot
- omap3-beagle: boot, suspend/resume (ret/off), cpuidle (ret/off)
- am335x-bone: boot
- am335x-boneblack: boot
- dra7xx-evm: boot
- omap5-uevm: boot
- omap4-panda: boot
- omap4-panda-es: boot, suspend/resume (ret)
- omap2430-sdp: boot
- omap3430-sdp: boot
- omap4430-sdp-es23plus: boot

Test branch location:

tree: https://github.com/t-kristo/linux-pm.git
branch: 3.19-rc1-prcm-cleanup

-Tero
