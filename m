From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 21:55:29 +0200
Subject: [PATCH v3 02/13] spi: sunxi: fix transfer timeout
In-Reply-To: <064955d033503f129c3e138b0563817d1fffab27.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <064955d033503f129c3e138b0563817d1fffab27.1465490774.git.hramrach@gmail.com>
Message-ID: <20160613195529.GB2600@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:46:49PM -0000, Michal Suchanek wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/1f94e877/attachment-0001.sig>
