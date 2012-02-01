From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 01 Feb 2012 09:47:33 +0100
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <CA+M3ks7h1t6DbPSAhPN6LJ5Dw84hSukfWG16avh2eZL+o4caJg@mail.gmail.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
 <20120127162624.40cba14e.akpm@linux-foundation.org>
 <20120130132512.GO25268@csn.ul.ie> <op.v8wlzbc53l0zgt@mpn-glaptop>
 <CA+M3ks7h1t6DbPSAhPN6LJ5Dw84hSukfWG16avh2eZL+o4caJg@mail.gmail.com>
Message-ID: <000201cce0be$240a88e0$6c1f9aa0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, January 31, 2012 6:17 PM Benjamin Gaignard wrote:

> I have rebase Linaro CMA test driver to be compatible with CMA v19, it now use
> dma-mapping API instead of v17 CMA API.
> A kernel for snowball with CMA v19 and test driver is available here: 
> http://git.linaro.org/gitweb?p=people/bgaignard/linux-snowball-test-cma-v19.git;a=summary
>
> From this kernel build, I have execute CMA lava (the linaro automatic test tool) 
> test, the same than we are running since v16, the test is OK.
> With previous versions of CMA some the test has found issues when the memory was 
> filled with reclaimables pages, but with v19 this issue is no more present.
> Test logs are here:  https://validation.linaro.org/lava-server/scheduler/job/10841
>
> so you can add:
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Thanks for Your contribution!

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
