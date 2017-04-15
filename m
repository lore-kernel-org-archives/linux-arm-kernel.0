From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Apr 2017 23:18:25 +0300
Subject: [PATCH 0/3] Add R8A7745/SK-RZG1E PFC support
Message-ID: <20170415201825.223149827@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20170410-v4.11-rc6' tag.  We're adding the R8A7745 PFC node and
then describe the pins for SCIF2 and Ether devices declared earlier. These
patches depend on the R8A7745 PFC suport in order to work properly.

[1/3] ARM: dts: r8a7745: add PFC support
[2/3] ARM: dts: sk-rzg1e: add SCIF2 pins
[3/3] ARM: dts: sk-rzg1e: add Ether pins

WBR, Sergei
