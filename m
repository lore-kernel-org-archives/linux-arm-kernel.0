From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 4 Apr 2014 16:40:43 +0200
Subject: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201404041628.55471.marex@denx.de>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
 <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
 <201404041628.55471.marex@denx.de>
Message-ID: <20140404144043.GB5529@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 04:28:55PM +0200, Marek Vasut wrote:
> On Friday, April 04, 2014 at 04:41:11 AM, Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in dts
> > node.
> > 
> > Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> 
> [...]
> 
> Since you will be fixing that superfluous return 0; (I actually wonder, did you 
> really test the driver at all before submitting it?) ...

Good question. @Yuan: Next time, please state what tests you did with
the new version of the driver.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/9d59872d/attachment.sig>
