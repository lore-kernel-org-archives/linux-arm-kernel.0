From: hejianet@gmail.com (Jia He)
Date: Mon, 2 Apr 2018 16:15:09 +0800
Subject: [PATCH v5 5/5] mm: page_alloc: reduce unnecessary binary search
 in early_pfn_valid()
In-Reply-To: <CAKv+Gu9jSXq7YN68Mk7WV4+aLr=nRtHmuQnHMdM8YhgeA-SYsg@mail.gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
 <1522636236-12625-6-git-send-email-hejianet@gmail.com>
 <CAKv+Gu9jSXq7YN68Mk7WV4+aLr=nRtHmuQnHMdM8YhgeA-SYsg@mail.gmail.com>
Message-ID: <75088758-f59c-c65a-6e88-116c1e6b6675@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/2/2018 3:00 PM, Ard Biesheuvel Wrote:
> How much does it improve the performance? And in which cases?
>
> I guess it improves boot time on systems with physical address spaces
> that are sparsely populated with DRAM, but you really have to quantify
> this if you want other people to care.
Yes, I write the performance in patch 0/5. I will write it in the patch 
description later.

-- 
Cheers,
Jia
