From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jun 2015 13:20:05 +0100
Subject: [PATCH 1/6] regulator: core: Don't spew backtraces on duplicate
 sysfs
In-Reply-To: <1433209679-31389-2-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150603122005.GL14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 06:47:54PM -0700, Stephen Boyd wrote:
> We don't consider a failure to add the sysfs node as a problem,
> so use sysfs_create_link_nowarn() so that we don't print a

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/4eaccb5d/attachment.sig>
