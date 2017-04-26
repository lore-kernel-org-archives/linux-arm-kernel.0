From: sstabellini@kernel.org (Stefano Stabellini)
Date: Wed, 26 Apr 2017 10:17:05 -0700 (PDT)
Subject: [PATCH 1/2] xen/arm, arm64: fix xen_dma_ops after 815dd18
 "Consolidate get_dma_ops..."
In-Reply-To: <20170426171348.GE9406@e104818-lin.cambridge.arm.com>
References: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
 <20170418142126.GE27592@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704191023120.31486@sstabellini-ThinkPad-X260>
 <alpine.DEB.2.10.1704241214100.16723@sstabellini-ThinkPad-X260>
 <f0667d8c-1c17-8d5f-a5d7-1e0d014e86ec@arm.com>
 <alpine.DEB.2.10.1704251021380.2875@sstabellini-ThinkPad-X260>
 <20170426111906.GA9406@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704260959440.2875@sstabellini-ThinkPad-X260>
 <20170426171348.GE9406@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1704261016450.2875@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Apr 2017, Catalin Marinas wrote:
> On Wed, Apr 26, 2017 at 10:00:30AM -0700, Stefano Stabellini wrote:
> > On Wed, 26 Apr 2017, Catalin Marinas wrote:
> > > On Tue, Apr 25, 2017 at 10:22:00AM -0700, Stefano Stabellini wrote:
> > > > On Tue, 25 Apr 2017, Julien Grall wrote:
> > > > > On 24/04/17 20:16, Stefano Stabellini wrote:
> > > > > > Given the outstanding regression we need to fix as soon as possible,
> > > > > > I'll queue these patches on the xentip tree for 4.12.
> > > > > 
> > > > > It looks like there is another rc for 4.11. I am wondering whether you could
> > > > > try to send a pull request to Linus so it can be fixed in 4.11?
> > > > 
> > > > No, especially without input from Russell.
> > > 
> > > You could add a "Fixes" tag to the first patch so that it gets
> > > back-ported to 4.11.x once it hits mainline (the second patch is just
> > > cosmetic):
> > > 
> > > Fixes: 815dd18788fe ("treewide: Consolidate get_dma_ops() implementations")
> > 
> > I did add:
> > 
> >   Cc: <stable@vger.kernel.org>        [4.11+]
> > 
> > I thought that would be enough to trigger a backport?
> 
> Either would do. I didn't see it in the patch you posted, that's why I
> mentioned it.

Thanks, I appreciated it!
