From: davem@davemloft.net (David Miller)
Date: Sun, 01 Dec 2013 20:09:06 -0500 (EST)
Subject: [PATCH 2/2] net: emaclite: add barriers to support Xilinx Zynq
 platform
In-Reply-To: <9045da6f-88e5-4a20-be68-477790588131@TX2EHSMHS023.ehs.local>
References: <1385623797-26034-1-git-send-email-sthokal@xilinx.com>
 <9045da6f-88e5-4a20-be68-477790588131@TX2EHSMHS023.ehs.local>
Message-ID: <20131201.200906.25118738399177322.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srikanth Thokala <srikanth.thokala@xilinx.com>
Date: Thu, 28 Nov 2013 12:59:57 +0530

> This patch adds barriers at appropriate places to ensure the driver
> works on Xilinx Zynq ARM-based SoC platform.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>

Memory barriers must have comments.

Specifically, the comment must describe what exactly is being ensured
by the memory barrier.  What entity must see what memory operations in
what order?
