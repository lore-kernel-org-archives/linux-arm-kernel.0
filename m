From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 17:41:42 +0000
Subject: [PATCH] regmap:change spinlock_flags into the union
In-Reply-To: <35FD53F367049845BC99AC72306C23D103EDAF89E148@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103EDAF89E148@CNBJMBX05.corpusers.net>
Message-ID: <20141215174142.GK11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 04:05:50PM +0800, Wang, Yalin wrote:
> This patch move struct regmap.spinlock_flags into the union of
> spinlock, so that we can shrink struct regmap size.

Applied, thanks.  Please always remember to CC your posts to the
relevant mailing lists - in the case of regmap that's linux-kernel.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/8ad3b2a0/attachment-0001.sig>
