From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Mon, 21 Dec 2015 12:30:47 +0100
Subject: [PATCH v8 0/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
Message-ID: <20151221123047.215306ce@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the eighth version of the patch set that adds inputs to sun4i-codec.

Changes compared to v7 are:
 - fix the routes for line and mic capturing.

The patches are on top of the branch "sunxi-next" in 
<git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git>.

Regards,
   Danny
---
Danny Milosavljevic (2):
  sun4i-codec: Add FM, Line and Mic inputs
  sun4i-codec: make it possible to use different codec_widgets for A10 and A20.

 b/sound/soc/sunxi/sun4i-codec.c |  230 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 215 insertions(+), 15 deletions(-)
