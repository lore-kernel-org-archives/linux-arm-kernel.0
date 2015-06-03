From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jun 2015 19:39:25 +0100
Subject: [PATCH 2/6] regulator: core: Print at debug level on debugfs
 creation failure
In-Reply-To: <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <1433209679-31389-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150603183925.GU14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 06:47:55PM -0700, Stephen Boyd wrote:

> The downside of this approach is that whoever gets to debugfs first
> the others who come later to not have any debugfs attributes associated
> with them.

Right, and we do it silently which I'm really not sure about (either
way).  Let me think...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/0948b86e/attachment.sig>
