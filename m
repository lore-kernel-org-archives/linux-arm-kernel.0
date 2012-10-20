From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Oct 2012 07:10:13 +0000 (UTC)
Subject: OMP35xx booting issue
In-Reply-To: <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
References: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com>
 <alpine.DEB.2.00.1210200627180.9865@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200629010.9865@utopia.booyaka.com>
 <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1210200709530.11523@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Anil Kumar wrote:

> devkit8000 is booting with kernel 3.5 and no much diff
> in kernel 3.6/3.5 board files
> 
> i am suspecting here
> 
> omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

Have you tried using omap2plus_defconfig?


- Paul
