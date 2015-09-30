From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 17:41:03 +0100
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
Message-ID: <20150930164103.GC15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 11:19:19AM +0100, Catalin Marinas wrote:
> On Wed, Sep 30, 2015 at 01:13:57AM +0300, Yury Norov wrote:

> >  - What for ILP32 on ARM64?
> > 	See https://lkml.org/lkml/2015/4/13/814
> > 	and http://permalink.gmane.org/gmane.comp.lib.uclibc.buildroot/121100
> > 	Briefly,
> > 	 - for compatibility;
> > 	 - for performance;
> > 	 - for memory saving.

> Does anyone actually need this ABI? And by "need" I don't mean a
> tick-box on product fliers but actually someone going to use it on real
> systems in the field. Because I'm not keen on maintaining an ABI in the
> kernel just as a PR exercise. I have yet to see conclusive benchmarks
> that ILP32 is a real win vs LP64 but happy to be proven wrong.

Indeed.  On that subject there was some discussion at Linaro Connect
last week about work (being done outside Linaro, not sure how public it
is at this point) to pull together the current state of the art into a
Docker container image which people can use for benchmarking and as a
reference for how to pull things together.  That should help with the
analysis, it'll at least make it easier for other people to reproduce
any benchmarking results.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/4a1d93cd/attachment.sig>
