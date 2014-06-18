From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 18 Jun 2014 12:54:07 +0800
Subject: [PATCH 0/2] add ahci_platform_get_of_property
In-Reply-To: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
Message-ID: <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of setting hflags in different files,  
ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host

Any other property required?

Zhangfei Gao (2):
  libahci_platform: add ahci_platform_get_of_property
  ahci: remove AHCI_HFLAG_NO_FBS setting

 .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
 drivers/ata/ahci_platform.c                        |    3 --
 drivers/ata/libahci_platform.c                     |   39 ++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

-- 
1.7.9.5
