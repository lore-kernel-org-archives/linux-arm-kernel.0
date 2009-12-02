From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Dec 2009 23:03:52 +0800
Subject: [GIT PULL] pxa: 1 minor mmc fix for -rc8
Message-ID: <f17812d70912020703j416028ady94a2b43817f27a2a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please help get the following minor mmc fix upstream, thanks.

The following changes since commit 81065518eda14ebbce1b48c98d5077b0a059d4a3:
  Pavel Machek (1):
        [ARM] pxa/spitz: fix compile regression on spitz

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Daniel Mack (1):
      [ARM] pxamci: call mmc_remove_host() before freeing resources

 drivers/mmc/host/pxamci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
