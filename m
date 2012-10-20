From: balbi@ti.com (Felipe Balbi)
Date: Sat, 20 Oct 2012 18:45:58 +0300
Subject: OMP35xx booting issue
In-Reply-To: <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
References: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com>
 <alpine.DEB.2.00.1210200627180.9865@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200629010.9865@utopia.booyaka.com>
 <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Message-ID: <20121020154427.GA7286@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(please don't top-post)

On Sat, Oct 20, 2012 at 12:37:58PM +0530, Anil Kumar wrote:
> devkit8000 is booting with kernel 3.5 and no much diff
> in kernel 3.6/3.5 board files
> 
> i am suspecting here
> 
> omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

you need to enable CONFIG_DMADEVICES, CONFIG_ASYNC_TX_DMA and
CONFIG_DMA_OMAP. That should sort it out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121020/1cd48c59/attachment.sig>
