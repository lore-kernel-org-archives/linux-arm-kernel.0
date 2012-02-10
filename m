From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 10 Feb 2012 19:10:40 +0100
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <20120127162624.40cba14e.akpm@linux-foundation.org>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
 <20120127162624.40cba14e.akpm@linux-foundation.org>
Message-ID: <00d901cce81f$4c3edc40$e4bc94c0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Saturday, January 28, 2012 1:26 AM Andrew Morton wrote:

> These patches don't seem to have as many acked-bys and reviewed-bys as
> I'd expect.  Given the scope and duration of this, it would be useful
> to gather these up.  But please ensure they are real ones - people
> sometimes like to ack things without showing much sign of having
> actually read them.
> 
> Also there is the supreme tag: "Tested-by:.".  Ohad (at least) has been
> testing the code.  Let's mention that.
> 
> 
> The patches do seem to have been going round in ever-decreasing circles
> lately and I think we have decided to merge them (yes?) so we may as well
> get on and do that and sort out remaining issues in-tree.

It looks that the CMA patch series reached the final version - I've just 
posted version 21 a few minutes ago. Most of the patches got acks from either 
Mel or Arnd and the remaining few needs only minor tweaking, but they affect
only CMA users, which we hope to fix once the series is merged. That's why I
would like to ask You to merge these patches to Your tree and finally give
them a try in linux-next kernel.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
