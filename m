From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 23 Jan 2017 12:54:11 +0100
Subject: linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c: 2 *
 pointless local variables ?
In-Reply-To: <VI1PR08MB1022BE7B66F95FEA77412DDD9C720@VI1PR08MB1022.eurprd08.prod.outlook.com>
References: <VI1PR08MB1022BE7B66F95FEA77412DDD9C720@VI1PR08MB1022.eurprd08.prod.outlook.com>
Message-ID: <534e45bf-8a2c-85e4-e18e-0c95a9f97e40@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.1.2017 12:39, David Binderman wrote:
> 
> Hello there,
> 
> [linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:301]: (style) Variable 'num_writes' is modified but its new value is never used.
> [linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:356]: (style) Variable 'read_count' is modified but its new value is never used.
> 
> Suggest either use these local variables in some way or delete them.
> 

I have sent patch which removes them.

Thanks,
Michal
