From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 01:22:34 +0300
Subject: [PATCH v5 0/3] Add R8A7791/Henninger board CAN DT support
Message-ID: <1652479.NHBlqJ9OaR@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141231-v3.19-rc2' tag. Here we add the CAN device tree support
for the R8A7791-based Henninger board. It depends on the clk driver RCAN clock
patch reposted today in order to work.

[1/3] ARM: shmobile: r8a7791: add CAN clocks
[2/3] ARM: shmobile: r8a7791: add CAN DT support
[3/3] ARM: shmobile: henninger: add CAN0 DT support

WBR, Sergei
