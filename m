From: rongjun.ying@csr.com (Rongjun Ying)
Date: Wed, 2 Jul 2014 10:45:40 +0800
Subject: [PATCH v2 0/2] ASoC: add CSR SiRFSoC audio USP interface driver
Message-ID: <1404269142-3557-1-git-send-email-rongjun.ying@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the SiRF USP controller driver, this
driver uses the USP as I2S or DSP_A mode interface.

Rongjun Ying (2):
  ASoC: sirf: Add audio usp interface driver
  ASoC: sirf: Add device tree binding for the USP audio device

 .../devicetree/bindings/sound/sirf-usp.txt         |  27 ++
 sound/soc/sirf/Kconfig                             |   6 +
 sound/soc/sirf/Makefile                            |   2 +
 sound/soc/sirf/sirf-usp.c                          | 415 +++++++++++++++++++++
 sound/soc/sirf/sirf-usp.h                          | 293 +++++++++++++++
 5 files changed, 743 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-usp.txt
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
