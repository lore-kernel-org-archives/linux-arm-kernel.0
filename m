From: dcb314@hotmail.com (David Binderman)
Date: Mon, 23 Jan 2017 11:39:35 +0000
Subject: linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c: 2 *
 pointless local variables ?
Message-ID: <VI1PR08MB1022BE7B66F95FEA77412DDD9C720@VI1PR08MB1022.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello there,

[linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:301]: (style) Variable 'num_writes' is modified but its new value is never used.
[linux-4.10-rc5/drivers/char/xilinx_hwicap/buffer_icap.c:356]: (style) Variable 'read_count' is modified but its new value is never used.

Suggest either use these local variables in some way or delete them.

Regards

David Binderman
