From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Jul 2014 01:58:14 +0400
Subject: [PATCH v3 0/3] Add R8A7791/Henninger board CAN DT support
Message-ID: <201407310158.15446.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-rc7-20140729' tag. Here we add the CAN device tree support
for the R8A7791-based Henninger board. It depends on the PFC CAN fix, R-Car CAN
driver clock support and device tree support patches, and the clk driver RCAN
clock patch posted recently in order to work.

[1/3] ARM: shmobile: r8a7791: add CAN clocks
[2/3] ARM: shmobile: r8a7791: add CAN DT support
[3/3] ARM: shmobile: henninger: add CAN0 DT support

WBR, Sergei
