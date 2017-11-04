From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  4 Nov 2017 19:09:38 +0800
Subject: [GIT PULL] arm: actions: dt64 for v4.15
In-Reply-To: <20171104110938.9019-1-afaerber@suse.de>
References: <20171104110938.9019-1-afaerber@suse.de>
Message-ID: <20171104110938.9019-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here's a (late) dt64 pull for Actions Semi.
This clock node is needed to make use of the full serial driver merged in 4.14.

Regards,
Andreas

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-dt-for-4.15

for you to fetch changes up to 965f94c77552d80f824229a6a68f7ca92a59e5ff:

  arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock (2017-11-04 18:21:10 +0800)

----------------------------------------------------------------
Actions Semi ARM64 based SoC DT for v4.15

This updates the Bubblegum-96 DT with a clock node for the debug UART.

----------------------------------------------------------------
Andreas F?rber (1):
      arm64: dts: actions: s900-bubblegum-96: Add fake uart5 clock

 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 7 +++++++
 1 file changed, 7 insertions(+)
