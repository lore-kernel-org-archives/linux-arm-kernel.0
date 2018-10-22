From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Mon, 22 Oct 2018 08:31:05 +0530
Subject: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <20181019080959.GL18839@dhcp22.suse.cz>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
 <20181019080959.GL18839@dhcp22.suse.cz>
Message-ID: <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2018 01:39 PM, Michal Hocko wrote:
> I planed to get to review this earlier but been busy. Anyway, this patch
> should be applied only after movability one to prevent from
> (theoretical) bisectability issues.

Sure, I can change the order there.

> 
> I would probably fold it into the one which defines arch specific hook.

Hmm but that may be like doing two functionality changes together. Adding one
more conditional check and at the same time wrapping it over with a new name
which is part of a new scheme. I would suggest keeping the patches separate.
