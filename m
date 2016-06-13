From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Jun 2016 11:12:34 +0100
Subject: [PATCH v4 00/14] fix some type infos and bugs for arm64/of numa
In-Reply-To: <575D0ABA.2010503@huawei.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <20160607135852.GA20477@arm.com> <575D0ABA.2010503@huawei.com>
Message-ID: <20160613101233.GB1605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 03:09:46PM +0800, Hanjun Guo wrote:
> On 2016/6/7 21:58, Will Deacon wrote:
> > On Tue, Jun 07, 2016 at 04:08:04PM +0800, Zhen Lei wrote:
> >> v3 -> v4:
> >> 1. Packed three patches of Kefeng Wang, patch6-8.
> >> 2. Add 6 new patches(9-15) to enhance the numa on arm64.
> >>
> >> v2 -> v3:
> >> 1. Adjust patch2 and patch5 according to Matthias Brugger's advice, to make the
> >>    patches looks more well. The final code have no change. 
> >>
> >> v1 -> v2:
> >> 1. Base on https://lkml.org/lkml/2016/5/24/679
> > If you want bug fixes to land in 4.7, you'll need to base them on a
> > mainline kernel.
> >
> 
> Rafael queued ARM64 ACPI NUMA support for 4.8, and this patch set is based
> on that with no urgent bugfixes, can this patch set be queued for 4.8?

Up to Catalin, since he's handling the 4.8 merge window. It would be really
nice if you could give us the heads up about dependencies like this in the
future, preferably *before* the base part has already been merged. That way,
it's easier to create shared topic branches and gives us more options if
we think that conflicts are likely to occur.

Will
