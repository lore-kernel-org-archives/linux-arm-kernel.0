From: csd@broadcom.com (Christian Daudt)
Date: Tue, 27 Aug 2013 10:31:16 -0700
Subject: [GIT PULL] ARM: late bcm SOC  for 3.12
Message-ID: <521CE264.5050308@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
  Please pull the branch below. It contains a couple of missing patches 
from last week's (still un-acked) pull requests.

  Thanks,
    csd

The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:

   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)

are available in the git repository at:

   git://github.com/broadcom/bcm11351.git tags/bcm-for-3.12-late-soc

for you to fetch changes up to ceb2ea195a4167bc1ee9d78b19220562b1524fba:

   mmc: sdhci-bcm-kona: Staticize sdhci_bcm_kona_card_event (2013-08-27 
10:17:25 -0700)

----------------------------------------------------------------
Late changes for 3.12 broadcom driver

----------------------------------------------------------------
Sachin Kamat (2):
       mmc: sdhci-bcm-kona: Remove unneeded version.h inclusion
       mmc: sdhci-bcm-kona: Staticize sdhci_bcm_kona_card_event

  drivers/mmc/host/sdhci-bcm-kona.c |    3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)
