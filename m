From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Mar 2016 12:12:10 +0000
Subject: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
In-Reply-To: <20160321114956.GD12319@e106622-lin>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com> <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
Message-ID: <20160321121210.GQ2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 11:49:56AM +0000, Juri Lelli wrote:

> But we'll still need to normalize this w.r.t the highest score we get on
> a specific platform, right? And while we are at normalizing it, it is
> probably simpler if we keep the frequency component as part of the
> number, IMHO. But, maybe keeping the frequency component separate is
> more acceptable from a DT binding perspective?

One possible issue with that: if we keep the frequency number as part of
the core number then that might cause issues for devices with variants
or system deployment decisions that remove some OPPs from a table.  If
the top OPP gets removed that would throw off the numbers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/b094a354/attachment.sig>
