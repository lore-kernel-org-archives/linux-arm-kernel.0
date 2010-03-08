From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 08 Mar 2010 13:57:12 +0800
Subject: About the phylib supporting of fec.c
Message-ID: <4B9491B8.2040403@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fred and Sascha,

I saw the patch to add phylib supporting of fec.c. And I am working on Ubuntu on 
Freescale iMX51 kernel. We met a bug about missing link status detection of the 
fec.c driver: https://bugs.launchpad.net/ubuntu/+source/linux-fsl-imx51/+bug/438687

I am going to make phylib work on imx51. Do you guys have any plan to update the 
patch or will it be applied to upstream?

Thanks,
--
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.138-1617-6545 Mobile
Ubuntu Kernel Team | Hardware Enablement Team
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
