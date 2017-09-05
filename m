From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  6 Sep 2017 00:32:52 +0200
Subject: [GIT PULL] ARM: actions: dt64 for v4.14
In-Reply-To: <20170905223252.9478-1-afaerber@suse.de>
References: <20170905223252.9478-1-afaerber@suse.de>
Message-ID: <20170905223252.9478-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's a (late) dt64 pull for Actions Semi.
This clock node is needed to make use of the new full serial driver.

Regards,
Andreas

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.14

for you to fetch changes up to f0e12dd55384d5ef53c6e15673d39133dfca5f0a:

  arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock (2017-09-06 00:14:38 +0200)

----------------------------------------------------------------
Actions Semi ARM64 based SoC DT for 4.14

This updates the Bubblegum-64 DT with a clock node for the debug UART.

----------------------------------------------------------------
Andreas F?rber (1):
      arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock

 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 7 +++++++
 1 file changed, 7 insertions(+)
