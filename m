From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:58:04 -0700
Subject: [GIT PULL 4/7] Broadcom maintainers changes for 4.12
In-Reply-To: <20170324175807.27272-1-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
Message-ID: <20170324175807.27272-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/maintainers

for you to fetch changes up to 38b06b9d00f7d4907fc18866ec766253aa34f1c6:

  Merge tag 'bcm2835-maintainers-next-2017-03-21' into maintainers/next (2017-03-24 10:14:50 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs MAINTAINERS file updates for
4.12, please pull the following:

- Jon adds himself as a maintainer for the BCM5301X SoCs (Northstar) since he has
  been contributing changes to these platforms for a while now

- Stephen Warren removes himself from the BCM2835 maintainers (Rasperrby Pi) since
  in his own words he has not been active that much lately

- Eric adds Stefan Wahren as a maintainer for the BCM2835 platform since he has
  been very active on it for neary 2 years now

----------------------------------------------------------------
Eric Anholt (1):
      MAINTAINERS: Add Stefan Wahren to bcm2835.

Florian Fainelli (1):
      Merge tag 'bcm2835-maintainers-next-2017-03-21' into maintainers/next

Jon Mason (1):
      MAINTAINERS: Add Jon Mason to BCM5301X maintainers

Stephen Warren (1):
      MAINTAINERS: remove swarren from bcm2835

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
