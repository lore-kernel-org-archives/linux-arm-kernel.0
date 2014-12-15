From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 15:35:29 +0000
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
In-Reply-To: <548EDDCD.4060203@samsung.com>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
 <548EDDCD.4060203@samsung.com>
Message-ID: <20141215153529.GC11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 02:10:37PM +0100, Krzysztof Koz?owski wrote:

> Hi Mark,

> Few days ago I posted similar patch:
> https://lkml.org/lkml/2014/12/5/268
> but no one have picked it up.

> Anyway the fix of yours seems fine to me.

I don't mind either way, it just seemed to be easier to report the bug
with a patch.  If Jeorg is busy perhaps it can go via the arm64 tree,
the issue is triggered by the addition of the platform there?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/9a3567c7/attachment.sig>
