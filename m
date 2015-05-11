From: davem@davemloft.net (David Miller)
Date: Mon, 11 May 2015 14:16:43 -0400 (EDT)
Subject: [PATCH v2] net: ll_temac: Use one return statement instead of two
In-Reply-To: <3a0fa74dd703db5dac4816ef15b6a512ef0f2ec0.1431353091.git.michal.simek@xilinx.com>
References: <3a0fa74dd703db5dac4816ef15b6a512ef0f2ec0.1431353091.git.michal.simek@xilinx.com>
Message-ID: <20150511.141643.1570113271442981674.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Mon, 11 May 2015 16:05:02 +0200

> Use one return statement instead of two to simplify the code.
> Both are returning the same value.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied, thanks.
