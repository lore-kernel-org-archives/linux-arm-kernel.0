From: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 5 Jul 2014 11:57:42 +0100
Subject: [GIT PULL] TDA998x fixes
Message-ID: <20140705105742.GA1811@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

Please incorporate the latest TDA998x fixes, which can be found at:

  git://ftp.arm.linux.org.uk/~rmk/linux-cubox.git tda998x-fixes

with SHA1 de4bf3d51fe38eaf90cb587e4eae1f3f0e056a54.

A number of relatively minor TDA998x fixes, the most serious of which
is the positioning of the drm_i2c_encoder_destroy call, which is marked
for inclusion in stable trees.

These changes are based on v3.15, and test merging with your drm-fixes
(0fcb70c30131) dated 27th June shows no conflicts.

This will update the following files:

 Documentation/devicetree/bindings/drm/i2c/tda998x.txt |  2 ++
 drivers/gpu/drm/i2c/tda998x_drv.c                     | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

through these changes:

Guido Mart?nez (1):
      drm/i2c: tda998x: move drm_i2c_encoder_destroy call

Jean-Francois Moine (1):
      drm/i2c: tda998x: fix lack of required reg in DT documentation

Russell King (2):
      drm/i2c: tda998x: faster polling for edid
      drm/i2c: tda998x: add some basic mode validation

Many thanks.
