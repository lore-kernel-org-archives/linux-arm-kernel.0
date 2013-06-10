From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 10 Jun 2013 10:13:32 -0700
Subject: [PATCH] arm: dt: zynq: Add support for the zc706 platform
In-Reply-To: <1370884204-2297-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1370884204-2297-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <546c1098-93ed-4ac0-851a-0ade4e356154@AM1EHSMHS010.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 10:10:04AM -0700, Soren Brinkmann wrote:
> Add a DT fragment for the zc706 Zynq platform. Also, adding a
> corresponding target to the Makefile and adding an appropriate
> compatibility string in the BSP.
I forgot to mention: This patch depends on the branch armsoc/zynq/clk.

	S?ren
