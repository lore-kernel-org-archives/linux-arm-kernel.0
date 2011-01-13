From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 13 Jan 2011 12:26:38 +0100
Subject: [patch 0/2] imx51 pwm support fixes.
Message-ID: <20110113112638.328269873@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patchset aims at getting imx51 pwm support into shape. The first patch
fix a build failure when trying to use imx51_add_mxc_pwm() and the other adds
a missing clock and fixes a test to detect which kind of pwm where's using.


Arnaud
