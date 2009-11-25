From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 12:12:30 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124162250.GA17481@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
	<20091124162250.GA17481@n2100.arm.linux.org.uk>
Message-ID: <20091125121230.GA3737@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 04:22:50PM +0000, Russell King - ARM Linux wrote:

> There isn't, because apparantly under git rules, as soon as I publish it
> in git form it must be fixed.  So I'm keeping the stuff private and only
> issuing patches on this mailing list.

Rebasing is only a big deal if it's a branch other people are supposed
to be working off, or (to a lesser extent) on a "final submission"
branch for reviewed and stable patches.  A branch that's used for work
in progress where the patches are being constantly revised isn't a
problem here.

The issue with branches other people are working off is that it's
painful for them to have to constantly rebase or otherwise update for
your history.  The issue with final submission branches is that rebasing
those means that the history no longer shows the tree that was actually
reviewed and accepted (and hopefully tested) which makes history
analysis to locate breakages such as bisection less useful.
