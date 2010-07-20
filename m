From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jul 2010 11:04:48 +0100
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
Message-ID: <20100720100448.GB32702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 20, 2010 at 11:14:22AM +0200, Eric Miao wrote:
> On Wed, Jul 14, 2010 at 4:09 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> > Since we're now using addruart to establish the debug mapping, we can
> > remove the io_pg_offst and phys_io members of struct machine_desc.
> >
> > Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Like this very much,
> 
> Acked-by: Eric Miao <eric.miao@canonical.com>
> 
> Russell,
> 
> I think it can be merged soon, need to rebase my 'machine_class' patches
> on top of your -devel branch then.

My devel branch is still very much in a state of flux - there's a
number of patches which are 'on-hold' for various reasons, and
various other patches which need merging on the various sub-topic
branches...

For these wide-ranging changes, what I've said in the past to people
is to get them in linux-next, and we'll sort out merging their code
into my tree towards the end of the cycle.
