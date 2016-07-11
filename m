From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Jul 2016 00:50:16 +0300
Subject: [PATCH 0/2] R8A7792 clock fixes
Message-ID: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160711-v4.7-rc7' tag. I've found a couple of issues in the
R8A7792 DT clock descriptions, so these patches are targeted as fixes for 4.8.

[1/2] ARM: dts: r8a7792: add PLL1 divided by 2 clock
[2/2] ARM: dts: r8a7792: remove ADSP clock

WBR, Sergei
