From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 May 2015 18:18:46 +0100
Subject: [PATCH 01/21] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1432565608-26036-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150525171846.GD21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 04:53:05PM +0200, Tomeu Vizoso wrote:
> ...by moving the locking to regulator_dev_lookup.

I appear to have only patches 1 and 10 of a 21 patch series.  It is
difficult to tell what the series might be about or how any of the
patches in it might be related to each other, it doesn't look like the
sort of obviously repetitive series which is easily understandable.
Please don't do things like this, if you're sending a series people need
to be able to tell what it is.

What's going on here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150525/7b62f9b0/attachment-0001.sig>
