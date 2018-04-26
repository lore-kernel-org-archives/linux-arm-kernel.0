From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Apr 2018 23:26:46 +0300
Subject: [PATCH 0/2] Add R8A77970/Eagle CAN-FD support
Message-ID: <4e5216bc-5f1b-ace4-1aea-02269cd206ac@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180426-v4.17-rc2' tag. We're adding the R8A77970 CAN-FD
device node and then enable single chnanel CAN-FD support on the Eagle board.

[1/2] arm64: dts: renesas: r8a77970: add CAN-FD support
[2/2] arm64: dts: renesas: eagle: add CAN-FD support

WBR, Sergei
