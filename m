From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:41:32 -0700
Subject: [PATCH 1/9] spi: sunxi: fix transfer timeout
In-Reply-To: <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820184132.GO12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:45PM -0000, Michal Suchanek wrote:

>  drivers/spi/spi-sun4i.c | 10 +++++++++-
>  drivers/spi/spi-sun6i.c | 10 +++++++++-

Are we *sure* we can't work on merging these drivers :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/ffc08de4/attachment.sig>
