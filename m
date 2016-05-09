From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 9 May 2016 16:51:57 +0200
Subject: [PATCH 0/5] Introduce per-domain page sizes
In-Reply-To: <57307863.1070706@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
 <20160509112138.GB13275@8bytes.org> <57307863.1070706@arm.com>
Message-ID: <20160509145157.GD13971@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 12:45:39PM +0100, Robin Murphy wrote:
> Thanks a lot! I was expecting to pick this up again after the merge
> window and post an updated version then; as you may already have
> found, patch 5 conflicts somewhat with the SMMUv2 context format
> changes in Will's updates branch. The correct resolution requires a
> bit of rewriting, so below is what that patch looks like when
> rebased on top of Will's branch. If you'd prefer it in actual merge
> resolution format, shout and I'll give that a go.

Okay, hmm, but the patch does not apply here, even after fixing the line
breaks. I'll push my tree soon, can you rebase this patch on-top the
core branch then? It should already contain patches 1-4.


	Joerg
