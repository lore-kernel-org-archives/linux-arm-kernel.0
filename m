From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 3 Nov 2016 10:22:39 -0700
Subject: [PATCH 0/2] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
References: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
Message-ID: <0a660010-5083-476a-b2c5-88d822089000@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/16 19:51, Huang Shijie wrote:
> 
> (2) The bug   
>    After I tested the libhugetlbfs, I found the test case "counter.sh"
>    will fail with the gigantic page (32M page in arm64 board).
> 
>    This patch set adds support for gigantic surplus hugetlb pages,
>    allowing the counter.sh unit test to pass.   

Hi,
Where is the counter.sh test? Where can I find it?

thanks.
-- 
~Randy
