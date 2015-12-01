From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 1 Dec 2015 10:24:02 +0200
Subject: [GIT PULL] remoteproc fixes for 4.4
Message-ID: <CAK=Wgbau=_1jcvu7D+UpuLacYfO9RW54Nwz6-KWE=ZcHKOiW0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-4.4-fixes

for you to fetch changes up to f42f79af16ce2e8fff49ea9ba4949d3abdd6f26f:

  remoteproc: fix memory leak of remoteproc ida cache layers
(2015-11-26 17:44:28 +0200)

----------------------------------------------------------------
Remoteproc fixes for 4.4: two 1-liners coming from Suman and Arnd.

----------------------------------------------------------------
Arnd Bergmann (1):
      remoteproc: avoid stack overflow in debugfs file

Suman Anna (1):
      remoteproc: fix memory leak of remoteproc ida cache layers

 drivers/remoteproc/remoteproc_core.c    | 2 ++
 drivers/remoteproc/remoteproc_debugfs.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
