From: davem@davemloft.net (David Miller)
Date: Mon, 09 Dec 2013 21:02:41 -0500 (EST)
Subject: [PATCH v2 1/2] net: emaclite: Remove unnecessary code that
 enables/disables interrupts on PONG buffers
In-Reply-To: <1386403849-3153-1-git-send-email-sthokal@xilinx.com>
References: <1386403849-3153-1-git-send-email-sthokal@xilinx.com>
Message-ID: <20131209.210241.1312012384456187129.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srikanth Thokala <sthokal@xilinx.com>
Date: Sat,  7 Dec 2013 13:40:48 +0530

> There are no specific interrupts for the PONG buffer on both
> transmit and receive side, same interrupt is valid for both
> buffers. So, this patch removes this code.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> Reviewed-by: Michal Simek <monstr@monstr.eu>

Applied.
