From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jul 2015 21:08:19 +0100
Subject: [PATCH v2 00/10] pwm: add support for atomic update
In-Reply-To: <20150720214913.73c47fa6@bbrezillon>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150720171950.GE11162@sirena.org.uk>
 <20150720214913.73c47fa6@bbrezillon>
Message-ID: <20150720200819.GN11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 09:49:13PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 20, 2015 at 05:31:57PM +0200, Boris Brezillon wrote:

> > > - dropped pwm-regulator patches (should be submitted separately)

> > I think the second patch needs to go in with this series doesn't it?  It
> > was just the enable one that was good to go immediately IIRC.

> I was planning on submitting those two patches after the PWM changes
> have been merged, but you're right, maybe we should think about a proper
> way to smoothly get all of them in the same release.

I see.  We should at least try to get the enable one in this time, I'd
like to just apply it and then either do a cross tree merge for the one
making use of the new functionality or (if the rest of the series gets
held up for some reason) just letting it get merged via Linus' tree.

> I have rebased my work on top your regulator/topic/pwm branch containing
> Lee's work [1].

> Note that patch 1 has changed a bit to take Lee's additions into
> account.

> Thierry, could you create a branch based on Mark's regulator/topic/pwm
> branch ?
> If everybody agrees on the solution I'll send a v3 rebasing my work on
> top of this topic branch.

I think that's fine for me, I can tag the PWM branch in my tree and
Thierry can pull that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/450dfbae/attachment.sig>
