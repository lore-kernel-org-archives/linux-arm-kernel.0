From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Fri, 27 Jan 2017 16:10:10 +0000
Subject: =?utf-8?B?W0dJVCBQVUxMXSBTVGkgRFQgZml4IGZvciB2NC4xMC1yY3PigIs=?=
Message-ID: <fec421f0-7515-c80d-3b36-969d63758a8b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please consider this set for inclusion into the next v4.10-rc.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-dt-for-v4.10-rc

for you to fetch changes up to 8413299cb3933dade6186bbee8363f190032107e:

   ARM: dts: STiH407-family: set snps,dis_u3_susphy_quirk (2017-01-27 
16:17:13 +0100)

----------------------------------------------------------------

STi DT fix:

Since v4.10-rc1, xhci is complaining in loop with :
[ 801.953836] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?
[ 801.960455] xhci-hcd xhci-hcd.0.auto: Cannot set link state.
[ 801.966611] usb usb6-port1: cannot disable (err = -32)

Set property "snps,dis_u3_susphy_quirk" in DT fix it.

----------------------------------------------------------------
Patrice Chotard (1):
       ARM: dts: STiH407-family: set snps,dis_u3_susphy_quirk

  arch/arm/boot/dts/stih407-family.dtsi | 1 +
  1 file changed, 1 insertion(+)
