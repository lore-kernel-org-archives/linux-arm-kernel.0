From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 21:56:20 +0200
Subject: [PATCH v3 04/13] spi: sunxi: expose maximum transfer size limit
In-Reply-To: <6962eec8da0b5255cafd7782bcc39ca19041c2b1.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <6962eec8da0b5255cafd7782bcc39ca19041c2b1.1465490774.git.hramrach@gmail.com>
Message-ID: <20160613195620.GD2600@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:46:50PM -0000, Michal Suchanek wrote:
> The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
> support so report the limitation. Same for sun6i.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/429a3724/attachment.sig>
