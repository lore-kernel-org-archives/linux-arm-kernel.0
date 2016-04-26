From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 02:55:16 +0300
Subject: [PATCH 0/3] MAINTAINERS: add new maintainers of NXP LPC32xx SoC
Message-ID: <1461714919-25577-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roland Stigge added initial support of NXP LPC32xx SoC series and
first boards powered by it, but for a while since v3.18-rc1 the
SoC support is unmaintained and became stale.

Vladimir Zapolskiy and Sylvain Lemieux expressed interest in
continuation of NXP LPC32xx maintenance, reflect this in MAINTAINERS
record file for better communication with Linux kernel community.

The maintenance change is in agreement with Arnd Bergmann:

  http://www.spinics.net/lists/arm-kernel/msg498129.html

Vladimir Zapolskiy (3):
  MAINTAINERS: move ARM/NXP LPC32xx record to ARM section
  MAINTAINERS: add new maintainers of NXP LPC32xx SoC
  MAINTAINERS: add ARM/NXP LPC32XX SoC specific drivers to the section

 MAINTAINERS | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.8.0.rc3
