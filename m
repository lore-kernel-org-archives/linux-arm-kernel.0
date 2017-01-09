From: david@lechnology.com (David Lechner)
Date: Mon,  9 Jan 2017 10:11:37 -0600
Subject: [RESEND 0/3] davinci_all_defconfig patches for LEGO MINDSTORMS EV3
Message-ID: <1483978300-403-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending the patches that were missing my Signed-off-by:

David Lechner (3):
  ARM: davinci_all_defconfig: enable DA8xx pinconf
  ARM: davinci_all_defconfig: Enable PWM modules
  ARM: davinci_all_defconfig: enable iio and ADS7950

 arch/arm/configs/davinci_all_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.7.4
