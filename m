From: leiwen@marvell.com (Lei Wen)
Date: Fri, 22 Oct 2010 18:14:38 +0800
Subject: [PATCH V3 0/6] pxa3xx_nand update series set
Message-ID: <1287742484-4276-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH V3 1/6] pxa3xx_nand: make scan procedure more clear
[PATCH V3 2/6] pxa3xx_nand: rework irq logic 
[PATCH V3 3/6] pxa3xx_nand: discard wait_for_event,write_cmd,__readid function
[PATCH V3 4/6] pxa3xx_nand: unify prepare command
[PATCH V3 5/6] pxa3xx_nand: mtd scan id process could be defined by driver itself
[PATCH V3 6/6] pxa3xx_nand: clean the keep configure code
