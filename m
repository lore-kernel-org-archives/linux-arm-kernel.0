From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 29 Feb 2012 20:15:31 +0100
Subject: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers driver
In-Reply-To: <20120216144504.GC2541@pengutronix.de>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
 <20120216144504.GC2541@pengutronix.de>
Message-ID: <20120229191531.GF30545@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 03:45:04PM +0100, Wolfram Sang wrote:
> On Wed, Feb 08, 2012 at 11:28:35PM +0800, Barry Song wrote:
> > From: Zhiwu Song <Zhiwu.Song@csr.com>
> > 
> > SiRFprimaII is the latest generation application processor from CSR?s
> > multi-function SoC product family.
> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> > 3.0.
> > There are two I2C controllers on primaII, features include:
> > * Two I2C controller modules are on chip
> > * RISC I/O bus read write register
> > * Up to 16 bytes data buffer for issuing commands and writing data
> >   at the same time
> > * Up to 16 commands, and receiving read data 16 bytes at a time
> > * Error INT report (ACK check)
> > * No-ACK bus protocols (SCCB bus protocols)
> > 
> > Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> > Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye@csr.com>
> > Signed-off-by: Yuping Luo <Yuping.Luo@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> 
> I am fine with it. Personally, I would have violated the 80 char limit
> a few times to keep stuff more readable, but this is taste, I guess.

Picked to my for 3.4 branch


-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/86e1eb23/attachment-0001.sig>
