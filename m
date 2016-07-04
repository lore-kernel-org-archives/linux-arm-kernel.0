From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 04 Jul 2016 23:51:11 +0300
Subject: [PATCH v2 0/3] Add R8A7792/Blanche PFC support
Message-ID: <2793535.9X0Tq7I1Mq@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160704-v4.7-rc6' tag. We're adding the R8A7792 PFC node and
then describe the pins for the SCIFs and SMSC LAN89218 Ethernet chip found on
the Blanche board. These patches depend on the R8A7792 PFC driver patchset
in order to work properly.

[1/3] ARM: dts: r8a7792: add PFC support
[2/3] ARM: dts: blanche: add SCIF pins
[3/3] ARM: dts: blanche: add Ethernet pins

WBR, Sergei
