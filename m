From: mhocko@kernel.org (Michal Hocko)
Date: Mon, 22 Oct 2018 09:16:25 +0200
Subject: [PATCH V2 1/5] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-2-git-send-email-anshuman.khandual@arm.com>
 <20181019080959.GL18839@dhcp22.suse.cz>
 <7d32fcdc-1ee3-7666-3b33-eda14ca8b380@arm.com>
Message-ID: <20181022071625.GS18839@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 22-10-18 08:31:05, Anshuman Khandual wrote:
> On 10/19/2018 01:39 PM, Michal Hocko wrote:
> > I would probably fold it into the one which defines arch specific hook.
> 
> Hmm but that may be like doing two functionality changes together. Adding one
> more conditional check and at the same time wrapping it over with a new name
> which is part of a new scheme. I would suggest keeping the patches separate.

I will surely not insist. If you think it is better this way then no
objections from me of course.

-- 
Michal Hocko
SUSE Labs
