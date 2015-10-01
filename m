From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Oct 2015 12:36:42 +0100
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <20151001111931.GD6963@e104818-lin.cambridge.arm.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20150930164103.GC15635@sirena.org.uk>
 <20151001111931.GD6963@e104818-lin.cambridge.arm.com>
Message-ID: <20151001113642.GI12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 12:19:31PM +0100, Catalin Marinas wrote:
> On Wed, Sep 30, 2015 at 05:41:03PM +0100, Mark Brown wrote:

> > Indeed.  On that subject there was some discussion at Linaro Connect
> > last week about work (being done outside Linaro, not sure how public it
> > is at this point) to pull together the current state of the art into a
> > Docker container image which people can use for benchmarking and as a
> > reference for how to pull things together.  That should help with the
> > analysis, it'll at least make it easier for other people to reproduce
> > any benchmarking results.

> That's fine and I would welcome it. However, I'm definitely against
> using non-agreed ABI and further spreading such toolchains (or kernel

You might want to speak to some of your colleagues about that...  in any
case I'll reply off list later today with information on the third party
working on this so you can get in touch, like I say I'm not sure how
public that work is at this point.

> patches; Linaro's tracking kernel has kept these patches for a long
> time, even though the ABI has been NAK'ed).

I know, I'm not thrilled about that either.  :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/fc22bf42/attachment.sig>
