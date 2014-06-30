From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Jun 2014 14:27:25 -0400
Subject: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <53AA158E.1040700@amd.com>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140624122639.GL10202@titan.lakedaemon.net>
 <53AA158E.1040700@amd.com>
Message-ID: <20140630182725.GZ23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 07:19:26PM -0500, Suravee Suthikulanit wrote:
> On 6/24/2014 7:26 AM, Jason Cooper wrote:
> >On Mon, Jun 23, 2014 at 07:32:58PM -0500, suravee.suthikulpanit at amd.com wrote:
> >>This patch set introduces support for MSI(-X) in GICv2m specification,
> >>which is implemented in some variation of GIC400.
> >>
> >>This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
> >>(https://lkml.org/lkml/2014/3/14/320).
> >
> >Is this a build, boot, or runtime dependency?
> >
> 
> For all of the above.

Ok, the gic change in #1 should be a trivial conflict to resolve, so
it'll be easiest for you guys to merge this with the other code you have
going into arm-soc.

Just keep me in the Cc and I'll Ack it when it's ready.

thx,

Jason.
