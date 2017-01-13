From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 14:00:10 -0600
Subject: [PATCH v2 0/2] ARM: davinci_all_defconfig: enable iio
Message-ID: <1484337612-11120-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following up on another conversation [1], this series includes a fixed up
patch to enable the iio subsystem in davinci_all_defconfig. I have also
included another patch to allocate extra interrupts that are needed for
iio triggers (this patch was previously submitted, but received no comments).

[1]: https://patchwork.kernel.org/patch/9500063/

David Lechner (2):
  ARM: davinci: Allocate extra interrupts
  ARM: davinci_all_defconfig: enable iio

 arch/arm/configs/davinci_all_defconfig    | 9 +++++++++
 arch/arm/mach-davinci/include/mach/irqs.h | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.7.4
