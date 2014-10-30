From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Oct 2014 12:50:11 -0700
Subject: [GIT PULL] Broadcom Cygnus SoC MAINTAINERS changes
In-Reply-To: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1414698612-26216-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-maintainers-v9

for you to fetch changes up to 693fe0581eb4a79cc42b1d0c30e91cd9f5a1a162:

  MAINTAINERS: Entry for Cygnus/iproc arm architecture (2014-10-30 11:11:16 -0700)

----------------------------------------------------------------
This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

These are the MAINTAINERS changes

----------------------------------------------------------------
Scott Branden (1):
      MAINTAINERS: Entry for Cygnus/iproc arm architecture

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
