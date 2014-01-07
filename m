From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 18:46:58 +0000
Subject: [PATCH 0/4] arm64 topology support
In-Reply-To: <20140107182355.GL31886@sirena.org.uk>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <20140107180545.GB14603@e102568-lin.cambridge.arm.com>
 <20140107182355.GL31886@sirena.org.uk>
Message-ID: <20140107184658.GN31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 06:23:55PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 06:05:45PM +0000, Lorenzo Pieralisi wrote:

> > I think cpu-map must only contain cluster nodes as descendant children. This
> > to prevent creative DTs with cluster and core nodes at top topology level.
> > Overall it makes sense, cores can only exist in a cluster container, might
> > seem churn but at least that's strict.

> That still leaves the question of what you want to happen with such
> maps.

I've implemented a warning for this; it seems more constructive than
rejecting such DTs outright.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/d23d963f/attachment.sig>
