From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 21:56:01 +0200
Subject: [PATCH v3 03/13] spi: sun4i: fix FIFO limit
In-Reply-To: <6495575d7c7e14da06f86d88a6a15042b4c6b96a.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <6495575d7c7e14da06f86d88a6a15042b4c6b96a.1465490774.git.hramrach@gmail.com>
Message-ID: <20160613195601.GC2600@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:46:49PM -0000, Michal Suchanek wrote:
> When testing SPI without DMA I noticed that filling the FIFO on the
> spi controller causes timeout.
> 
> Always leave room for one byte in the FIFO.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/6b657bdc/attachment.sig>
