From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 00:31:33 +0300
Subject: [PATCH v2 0/2] Add R8A7790 CAN DT support
Message-ID: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141231-v3.19-rc2' tag. Here we add the CAN device tree support
for the R8A7790 SoC (unfortunately, it's impossible to test CAN on the Lager
board). It depends on the clk driver RCAN clock patch reposted today in order
to work.

[1/2] ARM: shmobile: r8a7790: add CAN clocks
[2/2] ARM: shmobile: r8a7790: add CAN DT support

WBR, Sergei
