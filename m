From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 25 Apr 2014 02:39:38 +0400
Subject: [PATCH 0/2] Add R8A7791/Henninger board DT support
Message-ID: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.15-rc2-20140421' tag. Here we add support for the R8A7791-
based Henninger board AKA R-Car M2 Low Cost Development Platform (M2-LCDP);
this board is very like already supported Koelsch board, although some
differences do exist. The board can be booted using the device tree only, with
no pre-requisites...

[1/2] ARM: shmobile: Henninger: initial device tree
[2/2] ARM: shmobile: Henninger: add Ether DT support

WBR, Sergei
