From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 16 Feb 2012 15:45:04 +0100
Subject: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20120216144504.GC2541@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 11:28:35PM +0800, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
> 
> SiRFprimaII is the latest generation application processor from CSR?s
> multi-function SoC product family.
> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> 3.0.
> There are two I2C controllers on primaII, features include:
> * Two I2C controller modules are on chip
> * RISC I/O bus read write register
> * Up to 16 bytes data buffer for issuing commands and writing data
>   at the same time
> * Up to 16 commands, and receiving read data 16 bytes at a time
> * Error INT report (ACK check)
> * No-ACK bus protocols (SCCB bus protocols)
> 
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

I am fine with it. Personally, I would have violated the 80 char limit
a few times to keep stuff more readable, but this is taste, I guess.

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Ben, will you handle it?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120216/bc78461d/attachment-0001.sig>
