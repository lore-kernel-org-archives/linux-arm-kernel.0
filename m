From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 11:58:27 +0200
Subject: [PATCH v2] clk: add device tree fixed-factor-clock binding support
Message-ID: <1365760708-4763-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[I resend it because I forgot to add the mainling lists!]

Since august this patch finally find a user:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arc/boot/dts/abilis_*.dtsi.
So I resusrected this patch with small changed suggested by Christian
Ruppert.

- Adding CLK_OF_DECLARE
- Using IS_ERR to test the clk value

Thanks,

Gregory CLEMENT (1):
  clk: add device tree fixed-factor-clock binding support

 .../bindings/clock/fixed-factor-clock.txt          |   24 +++++++++++++
 drivers/clk/clk-fixed-factor.c                     |   36 ++++++++++++++++++++
 include/linux/clk-provider.h                       |    2 ++
 3 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fixed-factor-clock.txt

-- 
1.7.9.5
