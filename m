From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 12:42:41 +0000
Subject: [PATCH v2] regmap: Allow regmap_bulk_write() to work for
 "no-bus" regmaps
In-Reply-To: <20131226215204.GL31766@codeaurora.org>
References: <52AA42FD.4040503@codeaurora.org>
 <20131213104128.GT11044@sirena.org.uk>
 <20131213213707.GO21983@codeaurora.org>
 <20131216210153.GA3185@sirena.org.uk>
 <20131217023047.GC31766@codeaurora.org>
 <20131218184541.GH31886@sirena.org.uk>
 <52B897A1.8030205@codeaurora.org>
 <20131224125358.GB30815@sirena.org.uk>
 <20131226193416.GI31766@codeaurora.org>
 <20131226215204.GL31766@codeaurora.org>
Message-ID: <20131230124241.GU31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 01:52:04PM -0800, Stephen Boyd wrote:
> regmap_bulk_write() should decay to performing individual writes
> if we're using a "no-bus" regmap. Unfortunately, it returns an
> error because there is no map->bus pointer. Fix it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/8e244316/attachment.sig>
