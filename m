From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  6 Jul 2016 20:36:13 -0700
Subject: [GIT PULL 4/4] Broadcom MAINTAINERS file updates for 4.8 (resend)
In-Reply-To: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1467862574-6522-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/maintainers-part2

for you to fetch changes up to ccf62f5ab83f47796b87b4d3dff6fd33a6b02bb4:

  MAINTAINERS: Update BCM281XX/BCM11XXX/BCM216XX entry (2016-07-06 19:57:17 -0700)

----------------------------------------------------------------
This pull request contains MAINTAINERS file changes for Broadcom entries:

- Rafal updates the BCM5301x entry to include the internal Broadcom
  mailing-list so it's easy for engineers there to keep track of patches

- Jon updates the NSP regexp, updates the NS2, BCM63xx and Broadcom Mobile SoCs
  entry

- Florian changes L to M in all Broadcom ARM/ARM64 entries per feeedback

----------------------------------------------------------------
Florian Fainelli (1):
      MAINTAINERS: Change L to M for Broadcom ARM/ARM64 SoC entries

Jon Mason (4):
      MAINTAINERS: Fix nsp false-positives
      MAINTAINERS: Add NS2 entry
      MAINTAINERS: Update BCM63XX entry
      MAINTAINERS: Update BCM281XX/BCM11XXX/BCM216XX entry

Rafa? Mi?ecki (1):
      MAINTAINERS: Update entry for BCM5301X ARM

 MAINTAINERS | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)
