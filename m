From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 6 Nov 2012 11:15:25 +0200
Subject: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after
 re-enabling gic
In-Reply-To: <878vafg008.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-7-git-send-email-t-kristo@ti.com>
 <878vafg008.fsf@deeprootsystems.com>
Message-ID: <1352193325.8788.40.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 14:25 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Colin Cross <ccross@android.com>
> >
> > 'Workaround for ROM bug because of CA9 r2pX gic control'
> > register change disables the gic distributor while the secondary
> 
> Just to clarify: this is referring to PATCH 3/8 of this series, correct?
> 

Yes.

-Tero
