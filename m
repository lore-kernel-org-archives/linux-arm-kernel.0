From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Jun 2016 19:11:08 +0200
Subject: [GIT PULL] ARM: at91: dt for 4.8 #2
Message-ID: <20160621171108.GA16256@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the device tree for a new board (well, from 2006).
I don't expect to send you much more this cycle unless we get an
agreement on the TCB driver rework.

The following changes since commit 64c0703e269d442f0406b34e64e23744151ea276:

  ARM: dts: at91: calao: remove leftovers clock definition (2016-06-10 16:59:30 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.8-dt2

for you to fetch changes up to a4d750273eb67c538c9cc2cef846b9581db5234c:

  ARM: dts: at91: add at91sam9260ek board DT (2016-06-21 17:09:06 +0200)

----------------------------------------------------------------
DT Changes for 4.8 #2:
 - New board: at91sam9260ek

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: dts: at91: add at91sam9260ek board DT

 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/at91sam9260ek.dts | 211 ++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91sam9260ek.dts

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/06efc000/attachment.sig>
