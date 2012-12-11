From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 12 Dec 2012 10:19:19 +1100
Subject: linux-next: some merging notes
In-Reply-To: <20121212091552.02c72c8926f9f9147b080d68@canb.auug.org.au>
References: <20121212091552.02c72c8926f9f9147b080d68@canb.auug.org.au>
Message-ID: <1355267959.19932.40.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-12 at 09:15 +1100, Stephen Rothwell wrote:
> The powerpc tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git#next)
> contains a commit that breaks the building of
> lib/pSeries-reconfig-notifier-error-inject.c.  I applied a patch to
> linux-next to disable CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT.

I will put a fix in before I send the pull request.

Cheers,
Ben.
