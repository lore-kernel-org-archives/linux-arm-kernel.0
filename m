From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 5 Dec 2016 11:06:49 +0800
Subject: [PATCH v2 3/6] mm: hugetlb: change the return type for
 alloc_fresh_gigantic_page
In-Reply-To: <20161202135643.GK6830@dhcp22.suse.cz>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-4-git-send-email-shijie.huang@arm.com>
 <20161202135643.GK6830@dhcp22.suse.cz>
Message-ID: <20161205030648.GB13365@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 02:56:43PM +0100, Michal Hocko wrote:
> On Mon 14-11-16 15:07:36, Huang Shijie wrote:
> > This patch changes the return type to "struct page*" for
> > alloc_fresh_gigantic_page().
> 
> OK, this makes somme sense. Other hugetlb allocation function (and page
> allocator in general) return struct page as well. Besides that int would
> make sense if we wanted to convey an error code but 0 vs. 1 just doesn't
> make any sense.
> 
> But if you are changing that then alloc_fresh_huge_page should be
> changed as well.
Okay.

> 
> > This patch makes preparation for later patch.
> > 
> > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
Thanks a lot.

Thanks
Huang Shijie
