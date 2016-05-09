From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 9 May 2016 16:18:39 +0100
Subject: [PATCH 0/5] Introduce per-domain page sizes
In-Reply-To: <20160509145157.GD13971@8bytes.org>
References: <cover.1460048991.git.robin.murphy@arm.com>
 <20160509112138.GB13275@8bytes.org> <57307863.1070706@arm.com>
 <20160509145157.GD13971@8bytes.org>
Message-ID: <5730AA4F.4040303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/16 15:51, Joerg Roedel wrote:
> On Mon, May 09, 2016 at 12:45:39PM +0100, Robin Murphy wrote:
>> Thanks a lot! I was expecting to pick this up again after the merge
>> window and post an updated version then; as you may already have
>> found, patch 5 conflicts somewhat with the SMMUv2 context format
>> changes in Will's updates branch. The correct resolution requires a
>> bit of rewriting, so below is what that patch looks like when
>> rebased on top of Will's branch. If you'd prefer it in actual merge
>> resolution format, shout and I'll give that a go.
>
> Okay, hmm, but the patch does not apply here, even after fixing the line
> breaks. I'll push my tree soon, can you rebase this patch on-top the
> core branch then? It should already contain patches 1-4.

Bah, I saw last week's "Merge remote-tracking branch 
'will/for-joerg/arm-smmu/updates' into HEAD" commit on that branch 
without spotting it was no longer up to date, sorry. Yes, it's probably 
safest if I rebase on top of your merge of everything else - I'll keep 
an eye out.

Thanks,
Robin.

>
>
> 	Joerg
>
