From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 3 Oct 2018 13:27:58 +0200
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <789784ee-4830-753b-5d14-f5c7d90622c4@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <835085a2-79c2-4eb5-2c10-13bb2893f611@arm.com>
 <c0689b0c-4810-e0e8-354e-55c45d59b6d0@arm.com>
 <a6b96126-5571-2aa2-6deb-09a457afd781@arm.com>
 <bad51030-5f02-4fc9-741c-0fffbd690aca@arm.com>
 <789784ee-4830-753b-5d14-f5c7d90622c4@arm.com>
Message-ID: <20181003112758.GC4714@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03-10-18 12:17:52, Suzuki K Poulose wrote:
[...]
> I have been under the idea that all the checks at the same level could
> have the same indentation. (i.e, 2 tabs in this case for each). Looks
> like there is no rule about it. How about replacing it with a
> switch..case  ?

I would simply follow the existing indentation style in that function.
Is this really worth discussig, anyway? Does the proposed change makes
the code harder to read?

-- 
Michal Hocko
SUSE Labs
