From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Sep 2014 11:18:54 +0100
Subject: [PATCH] ARM: configs: Enable cpufreq-cpu0 for multi_v7_defconfig
In-Reply-To: <3122457.yORdifPoE7@wuerfel>
References: <1409486979-26869-1-git-send-email-broonie@kernel.org>
 <3122457.yORdifPoE7@wuerfel>
Message-ID: <20140901101854.GL29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 11:41:01AM +0200, Arnd Bergmann wrote:
> On Sunday 31 August 2014 13:09:39 Mark Brown wrote:
> > Many boards share the cpufreq-cpu0 driver meaning that if we enable it in
> > multi_v7_defconfig we can get a reasonable amount of functional utility for
> > systems and test coverage for a fairly small increase in kernel size.

> > Signed-off-by: Mark Brown <broonie@kernel.org>

> Do we need this in 3.17, or should it go in during the merge window?

It's not a bug fix; it'd be nice to have it there from the point of view
of some testing I'm doing on the defconfig and it should be safe but
it's not a regression or anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/437d53ce/attachment.sig>
