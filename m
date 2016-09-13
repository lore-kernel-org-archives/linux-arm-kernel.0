From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 13 Sep 2016 20:38:49 +0800
Subject: [PATCHv3 00/11] crypto: omap HW crypto fixes
In-Reply-To: <1470306526-27219-1-git-send-email-t-kristo@ti.com>
References: <1470306526-27219-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160913123849.GA31890@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 01:28:35PM +0300, Tero Kristo wrote:
> Hi,
> 
> This revision took quite a bit time to craft due to the rework needed
> for sham buffer handling and export/import. I ended up implementing
> a flush functionality for draining out the sham buffer when doing
> export/import; just shrinking the buffer to sufficiently small size
> impacted the performance with small data chunks too much so I dropped
> this approach.
> 
> The series also fixes a couple of existing issues with omap2/omap3
> hardware acceleration, I ran a full boot test / crypto manager
> test suite on all boards accessible to me now.
> 
> Based on top of latest mainline, which is somewhere before 4.8-rc1
> as of writing this, I am unable to rebase the series during the next
> three weeks so wanted to get this out now. Targeted for 4.9 merge
> window, some fixes could be picked up earlier though if needed.

I have applied patches 1,4-5,7-11.  Some of them didn't apply
cleanly so please check the result in my tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
