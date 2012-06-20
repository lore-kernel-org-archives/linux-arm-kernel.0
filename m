From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jun 2012 11:00:15 +0100
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <20120620090126.GO28394@pengutronix.de>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
 <20120619181717.GE28394@pengutronix.de>
 <CACKLOr1zCp2NfLjBrHjtXpmsFMHqhoHFPpghN=Tyf3YAcyRrYg@mail.gmail.com>
 <20120620090126.GO28394@pengutronix.de>
Message-ID: <20120620100015.GA30243@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:01:26AM +0200, Sascha Hauer wrote:
> On Wed, Jun 20, 2012 at 09:51:32AM +0200, javier Martin wrote:

> > Our platfrom, 'visstrim_m10' doesn't currently support devicetree yet,
> > so it would be highly difficult for us to test it at the moment.
> > Couldn't you add devicetree support in a later patch?

> I try to motivate people moving to devicetree. At some point I'd like to
> get rid of the platform based boards in the tree. Adding new platform
> seems like delaying this instead of working towards a platform board
> free Kernel.
> Any other opinions on this?

The approach a lot of platforms have been taking is that it's OK to keep
on maintaining existing boards using board files (especially for trivial
things like adding new devices).
