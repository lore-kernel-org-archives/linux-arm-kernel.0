From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 19 Dec 2015 03:45:11 +0100
Subject: [PATCH v7 0/2] sun4i-codec: Add FM, Line and Mic inputs
Message-ID: <20151219034511.372575d3@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the seventh version of the patch set that adds inputs to sun4i-codec.

Changes compared to v6 are:
 - preparation for different A20, A10 controls is now in an extra patch.
 - all register definitions are now at the top
 - sun7i-specific things (A20-specific things) are now less grouped-together.

The patches are on top of the branch "sunxi-next" in 
<git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git>.

Regards,
   Danny
---
Danny Milosavljevic (2):
  sun4i-codec: Add FM, Line and Mic inputs
  sun4i-codec: make it possible to use different codec_widgets for A10 and A20.

 sound/soc/sunxi/sun4i-codec.c |  223 +++++++++++++++++++++++++++++++++++++---
