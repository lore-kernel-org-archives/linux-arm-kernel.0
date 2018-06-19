From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Jun 2018 16:31:04 -0700
Subject: [GIT PULL 3/3] Broadcom maintainers-arm64 fixes for 4.18
In-Reply-To: <20180619233104.32173-1-f.fainelli@gmail.com>
References: <20180619233104.32173-1-f.fainelli@gmail.com>
Message-ID: <20180619233104.32173-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/maintainers-arm64-fixes

for you to fetch changes up to d64324acdb7052b08b13ffc8c12af232c6a29afd:

  MAINTAINERS: Update Broadcom iProc entry with Stingray (2018-06-18 09:28:36 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs MAINTAINERS file
fixes for 4.18, please pull the following:

- Florian fixes the entry for the Northstar2 SoCs which was somehow lost
  during a directory move. He also adds an entry for the Stingray SoCs
  which was missing from the day files were added

----------------------------------------------------------------
Florian Fainelli (2):
      MAINAINTERS: Corrected Broadcom Northstar2 entry
      MAINTAINERS: Update Broadcom iProc entry with Stingray

 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
