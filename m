From: b32955@freescale.com (Huang Shijie)
Date: Tue, 10 Sep 2013 14:59:07 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130909151450.GI29403@sirena.org.uk>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
Message-ID: <522EC33B.9000009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?09? 23:14, Mark Brown ??:
> So then an abstraction which hides the details of which commands are
> needed from the drivers seems sensible?
sorry, Mark. I feel confused at this comment, i don't catch your meaning. :(

Since I do not expose any details in the spi-nor.h
(i only add some commands in this header), how can i hides the details
with an abstraction?

could you explain it more clearly?



thanks
Huang Shijie
