From: steve.capper@arm.com (Steve Capper)
Date: Mon, 20 Aug 2012 08:27:07 -0000
Subject: ARM hugetlb support?
Message-ID: <20120820082514.GF27631@e103986-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

n Mon, Aug 20, 2012 at 00:18:12AM +0100, Grazvydas Ignotas wrote:
> Hello,
Hello Grazvydas,

> I've found that hugetlb support patches have been posted some months
> ago [1]. I've been testing them with very good results [2]. Are there
> still plans to further develop them and eventually merge them?
>

We are currently working on HugeTLB and Transparent HugePage support for both
LPAE and non-LPAE memory descriptors. The non-LPAE HugeTLB patches are based
on Bill's.

I hope to get some patches out to the list soon.

-- 
Steve
