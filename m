From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Sep 2015 09:24:17 -0700
Subject: next-20150922 build: 1 failures 346 warnings (next-20150922)
In-Reply-To: <E1ZeORj-0001FG-G8@optimist>
References: <E1ZeORj-0001FG-G8@optimist>
Message-ID: <20150922162417.GI30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 03:21:29PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c:315:3: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]

due to 511e6bc071db148 (net: add Hisilicon Network Subsystem DSAF
support) in the networking tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/c08fd949/attachment.sig>
