From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Apr 2017 00:09:41 +0300
Subject: [PATCH 0/3] Add R8A7743/SK-RZG1M PFC support
Message-ID: <20170414210941.143838720@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20170410-v4.11-rc6' tag.  We're adding the R8A7743 PFC node and
then describe the pins for SCIF0 and Ether devices described eralier. These
patches depend on the R8A7743 PFC suport in order to work properly.

[1/3] ARM: dts: r8a7743: add PFC support
[2/3] ARM: dts: sk-rzg1m: add SCIF0 pins
[3/3] ARM: dts: sk-rzg1m: add Ether pins

WBR, Sergei
