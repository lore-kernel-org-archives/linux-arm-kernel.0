From: azhongweiwen@sina.com (abbrous)
Date: Tue, 28 Feb 2017 17:15:42 +0800
Subject: help: vga behind pci bridge, bridge not forwarding
Message-ID: <mailman.3.1488273380.26981.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello,

I want to ask a question, anybody can help me?

I have a armv8 compatible machine, and my only vga device is behind a bridge, I found this bridge can not route address: vgaarb: decodes=io+mem,owns = none (in dmesg log). And I don't have PCI_PROBE_ONLY in device tree. AND I noticed in file vgaarb.c there just have one BRIDGE FORWARDING check in a while loop. Before this check, bridge forwarding bit (write PCI_BRIDGE_CTL_VGA to BRIDGE_CONTROL register?)havn't set in bus enumetation routine.

My question is how and where to add some code to repair this problem? Kernel version: 4.9.9.

Thanks in advance.

Send from mobile
