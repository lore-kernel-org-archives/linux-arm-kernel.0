From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 27 Apr 2018 22:10:55 +0300
Subject: [PATCH 0/2] Add R8A77980/Condor CAN-FD support
Message-ID: <c184f961-2f98-532f-ed02-6f3751256d9c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180426-v4.17-rc2' tag. We're adding the R8A77980 CAN-FD
device node and then enable single channel CAN-FD support on the Condor board.

[1/2] arm64: dts: renesas: r8a77980: add CAN-FD support
[2/2] arm64: dts: renesas: condor: add CAN-FD support

WBR, Sergei
