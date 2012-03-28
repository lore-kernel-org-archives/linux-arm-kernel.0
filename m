From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 10:54:50 +0100
Subject: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add
 device tree support
In-Reply-To: <87k426vy9r.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
 <m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
 <m239abgc32.fsf@bob.laptop.org>
 <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
 <m2vcn0496y.fsf@bob.laptop.org> <87k426vy9r.fsf@laptop.org>
Message-ID: <20120328095450.GA23005@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 11:50:24AM -0400, Chris Ball wrote:
> On Tue, Feb 21 2012, Chris Ball wrote:
> > On Tue, Feb 21 2012, Kukjin Kim wrote:

> >> I created topic branch for this we talked. You can pull that following:
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> >> v3.4-for-cjb

> >> If any problems, please kindly let me know.

> > Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
> > to Linus.)

> I was expecting you to merge these patches, but they aren't in the
> arm-soc tree and haven't been sent to Linus, and we're in the last few
> days of the merge window.

> As a result I'm dropping this tree -- and all of the patches that I
> have on top of it -- from mmc-next so that I can get a pull request
> out.  This means that I'm dropping:

If they're already in your tree why not just send them to Linus?  Given
that everything's in git I don't understand why you'd need Kukjin to
push them separately or what the benefit of that would be?

This is all extremely frustrating fromm the contributor point of view.
