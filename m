From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 12 Oct 2015 13:36:13 -0700
Subject: [PATCH 14/20] pxa2xx-flash: switch from ioremap_cache to memremap
In-Reply-To: <20151012203101.GM107187@google.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221651.32203.63446.stgit@dwillia2-desk3.jf.intel.com>
 <20151012175803.GL107187@google.com>
 <20151012203101.GM107187@google.com>
Message-ID: <CAPcyv4jBaM4jASAgY6O1if+LbYW7TdFBkMt8ZDATL7wrE7LUEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 1:31 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Mon, Oct 12, 2015 at 10:58:03AM -0700, Brian Norris wrote:
>> You missed linux-mtd again. Please use scripts/get_maintainer.pl next
>> time to at least get the relevant mailing list(s). (The individual CC's
>> are not always necessary, but the subsystem lists definitely are.)
>
> Anyway, pushed to l2-mtd.git.
>

Thanks Brian, I'll watch out for that next time.
