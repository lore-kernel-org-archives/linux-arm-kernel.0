From: bill4carson@gmail.com (bill4carson)
Date: Tue, 21 Aug 2012 09:55:17 +0800
Subject: ARM hugetlb support?
In-Reply-To: <CANOLnOPLLQ=Cy5rvf5J7R96whrvLKO4HW9nVn4rQXqXCTVgCPA@mail.gmail.com>
References: <CANOLnOPLLQ=Cy5rvf5J7R96whrvLKO4HW9nVn4rQXqXCTVgCPA@mail.gmail.com>
Message-ID: <5032EA85.9030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?08?20? 07:18, Grazvydas Ignotas wrote:
> Hello,
>
> We are developing an application that's drawing various geometry on
> 1024x1024 framebuffer (lines, triangles, etc) and is running on
> Cortex-A8 CPU. It seems this kind of application is suffering badly
> from TLB misses, as A8 only has 32 entry TLB cache.
>
> I've found that hugetlb support patches have been posted some months
> ago [1]. I've been testing them with very good results [2]. Are there
> still plans to further develop them and eventually merge them?
>
Hi, Grazvydas

I'm glad you got performance boost with my hugetlb patch!

It's a pity this patch series probably will not be developed.
I really don't have much time to continue with the development,
especially provide statistics how arm huge tlb could be tunned
well to produce better performance, that's based on much testing
and also application specific.

Anyway, query and discussion are always welcome.

>
> [1] http://marc.info/?l=linux-arm-kernel&m=132912620601308&w=2
> [2] Cycle measurements of rendering full scene (using cycle counter in
> A8), x1000 cycles:
>
>         normal hugetlb improvement
> scene1 28507  21351   34%
> scene2 11710  10138   16%
> scene3 17178  13631   26%
> scene4 4372   3810    15%
> scene5 3525   3255    8%
>

-- 
Love each day!

--bill
