From: davem@davemloft.net (David Miller)
Date: Thu, 13 Feb 2014 18:08:00 -0500 (EST)
Subject: [PATCH v2 1/2] net: axienet: Fix compilation error
In-Reply-To: <2082312fdbceca394080302b1709a5f71d7d3652.1392275432.git.michal.simek@xilinx.com>
References: <cover.1392275432.git.michal.simek@xilinx.com>
 <cover.1392275432.git.michal.simek@xilinx.com>
 <2082312fdbceca394080302b1709a5f71d7d3652.1392275432.git.michal.simek@xilinx.com>
Message-ID: <20140213.180800.778415248437011159.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 13 Feb 2014 08:10:42 +0100

> Add missing header to fix compilation error.
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1575:22:
>  error: undefined identifier 'irq_of_parse_and_map'
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1576:22:
>  error: undefined identifier 'irq_of_parse_and_map'
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied.
