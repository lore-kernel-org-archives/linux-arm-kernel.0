From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 14:29:07 -0700
Subject: [PATCH 1/9] spi: sunxi: fix transfer timeout
In-Reply-To: <20150820211850.GI30520@lukather>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
 <20150820184132.GO12027@sirena.org.uk>
 <20150820193433.GH30520@lukather>
 <20150820210830.GS12027@sirena.org.uk>
 <20150820211850.GI30520@lukather>
Message-ID: <20150820212907.GV12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:18:50PM +0200, Maxime Ripard wrote:

> at the driver level. And I'm not really sure that we can do much more
> at the framework level either, except maybe handling the timeout
> directly (but then the drivers would have to handle the recovering
> after a timeout too).

We have handle_err() for that sort of cleanup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/aa6e52ea/attachment.sig>
