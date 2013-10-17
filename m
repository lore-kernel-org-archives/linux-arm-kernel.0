From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Thu, 17 Oct 2013 17:01:09 +0800
Subject: [PATCHv1 0/8] ALSA: Add SAI driver and enable SGT15000 codec.
Message-ID: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is mostly Freescale's SAI SoC Digital Audio Interface driver implementation. And the implementation is only compatible with device tree definition.

This patch series is based on linux-next and has been tested on Vybrid VF610 Tower board using device tree.


Added in v1:
- Add SAI SoC Digital Audio Interface driver.
- Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
- Enables SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
- Add device tree bindings for Freescale SAI.
- Revise the bugs about the sgt15000 codec.
- Add SGT15000 based audio machine driver.
- Enable SGT15000 codec based audio driver node for VF610.
- Add device tree bindings for Freescale VF610 sound.
