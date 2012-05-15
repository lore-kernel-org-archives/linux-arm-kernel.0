From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 18:42:25 +0200
Subject: [PATCH 0/1] Enable sound on mx31_3ds
Message-ID: <1337100146-16459-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Here is the sound support for mx31_3ds.
It successfully outputs sound on the loudspeaker.
It needs the patchset: "MC13783 sound support".

Philippe R?tornaz (1):
  mx31_3ds: Add sound support

 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c |   22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)
