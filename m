From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Dec 2013 16:02:18 +0000
Subject: [PATCH] arm64: cmpxchg: update macros to prevent warnings
In-Reply-To: <20131220141000.GA11954@localhost>
References: <1387543334-14036-1-git-send-email-broonie@kernel.org>
 <20131220141000.GA11954@localhost>
Message-ID: <20131220160218.GW31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 02:10:02PM +0000, Catalin Marinas wrote:

> I merged the previous one (should be in -next as of last night), I guess
> it's the same since the patch doesn't have a version number. But I

It's the same patch, I was resending it because it had been a while with
no response.

> wonder whether uses of cmpxchg without checking the return value are
> sane.

IIRC it was used as part of another macro which did have some reasonable
uses without checking the return value.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/36a0404d/attachment.sig>
