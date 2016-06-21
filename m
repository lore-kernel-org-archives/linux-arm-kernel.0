From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Jun 2016 19:03:06 +0200
Subject: [GIT PULL] ARM: at91: drivers for 4.8 #2
Message-ID: <20160621170306.GA15727@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here are two simple fixes for our memory drivers.

The following changes since commit 1fdab21d1d52a85c31f932844242fec5fb81daac:

  memory: atmel-ebi: add DT bindings documentation (2016-06-02 08:32:25 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-drivers2

for you to fetch changes up to 8a86a093ca3b924e6c2d5267cffb809965582a8d:

  memory: atmel-ebi: make it explicitly non-modular (2016-06-21 17:17:45 +0200)

----------------------------------------------------------------
Drivers for 4.8 #2:
 - Make memory drivers explicitly non-modular

----------------------------------------------------------------
Paul Gortmaker (2):
      memory: atmel-sdramc: make it explicitly non-modular
      memory: atmel-ebi: make it explicitly non-modular

 drivers/memory/atmel-ebi.c    |  9 ++-------
 drivers/memory/atmel-sdramc.c | 11 ++++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
