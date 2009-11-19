From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 19 Nov 2009 15:23:01 +0100
Subject: [PATCH 0/6] mx31moboard: patches for next merge window (V3) 
Message-ID: <1258640588-12705-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are the patches I would like to push during the next merge window for
the mx31moboard platform.

Sascha, I have seen that you already have commited last version to your
mxc-master-pu branch, could you please update with that series ?

It consists of a fix for a small hardware design issue for the main serial
port, a few GPIOs used on the robots that are declared, camera support and
finally MC13783 support as it is now getting ready.

For MC13783, RTC should come to mainline soon and it works well.

The camera part works for one camera. The soc_camera needs some reworking
before we are able to support the two cameras we have on the robot

USB host support for mx31 should make into next merge window and is now
part of this series for the mx31moboard platform.

Changes since v1:
- changed the patches order
- support for a single camera
- corrected typos and comments from earlier version

Changes since v2:
- moved mx3_camera include to the correct patch (thanks Guennadi)
- moved SPIDEV device init into marxbot file
- added usb host support

Val
