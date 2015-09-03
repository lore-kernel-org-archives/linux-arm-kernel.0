From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Sep 2015 17:42:09 +0100
Subject: [PATCH] ARM64: PCI: do not enable resources on PROBE_ONLY systems
In-Reply-To: <20150903163504.GH829@google.com>
References: <1438262039-32085-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150828211444.GA27890@google.com>
 <20150829124457.GA18125@red-moon> <20150831132803.GB647@google.com>
 <20150831163314.GA19309@red-moon>
 <CAErSpo5188hGiySG+JweWOvfj6aZtAfVta4=0wwwRmMTp+9tFg@mail.gmail.com>
 <20150903163504.GH829@google.com>
Message-ID: <20150903164209.GI877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, Sep 03, 2015 at 05:35:04PM +0100, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2015 at 11:49:20AM -0500, Bjorn Helgaas wrote:
> > OK, if it fixes a problem in my v4.3 pull request, we need to merge
> > it.  I missed the connection, probably because I was browsing the
> > v4.2-rc1 tree, which wouldn't have those changes.
> > 
> > It's OK with me to merge it via the arm64 tree.
> 
> Do you need me to do anything with this?  It'd be nice to get it in
> before -rc1.  The PCI changes have already been merged, and it'd be
> nice to mention the commit that this fixes.

Nope, it's queued in the arm64 tree. I'm just waiting for a dependent
branch in -tip to get merged before I send my pull request.

Cheers,

Will
