From: shijie.huang@arm.com (Huang Shijie)
Date: Fri, 9 Dec 2016 17:58:03 +0800
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <20161208095253.GB8330@dhcp22.suse.cz>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
 <20161205093100.GF30758@dhcp22.suse.cz>
 <20161206100358.GA4619@sha-win-210.asiapac.arm.com>
 <20161207150237.GC31797@dhcp22.suse.cz>
 <20161208093623.GA4551@sha-win-210.asiapac.arm.com>
 <20161208095253.GB8330@dhcp22.suse.cz>
Message-ID: <20161209095801.GA4405@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 10:52:54AM +0100, Michal Hocko wrote:
> On Thu 08-12-16 17:36:24, Huang Shijie wrote:
> > On Wed, Dec 07, 2016 at 11:02:38PM +0800, Michal Hocko wrote:
> [...]
> > > I haven't yet checked your patchset but I can tell you one thing.
> >
> > Could you please review the patch set when you have time? Thanks a lot.
> 
> From a quick glance you do not handle the reservation code at all. You
Thanks, I will study the code again, and try to find What we need to do
with the reservation code.

> just make sure that the allocation doesn't fail unconditionally. I might
> be wrong here and Naoya resp. Mike will know much better but this seems
> far from enough to me.
> 
> Well, this would take me quite some time and basically restudy the whole
> hugetlb code again. What you are trying to achieve is not a simple "fix
> a test case" thing. You are trying to implement full featured giga pages
> suport. And as I've said this requires a deeper understanding of the
> current code and clean it up considerably wrt. giga pages. This is
> definitely desirable plan longterm and I would like to encourage you for
> that but it is not a simple project at the same time. 
Okay, I will try to implement the full featured giga pages support. :)

But I feel confused at the "full featured". If the patch set can pass
all the giga pages tests in the libhugetlbfs, can we say it is "full
featured"? Or some one reviews this patch set, and say it is full
featured support for the giga pages.

Thanks
Huang Shijie
