From: ross.zwisler@linux.intel.com (Ross Zwisler)
Date: Tue, 04 Aug 2015 10:53:40 -0600
Subject: [PATCH v3 24/24] pmem: convert to generic memremap
In-Reply-To: <CAPcyv4gCPyXwwgjidaUaNyNe8ZitmwVa-NF7pBT-y3rV4XBUzA@mail.gmail.com>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730165553.33962.20257.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1438622487.9404.2.camel@linux.intel.com>
 <CAPcyv4gCPyXwwgjidaUaNyNe8ZitmwVa-NF7pBT-y3rV4XBUzA@mail.gmail.com>
Message-ID: <1438707220.12666.7.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-08-03 at 11:01 -0700, Dan Williams wrote:
> On Mon, Aug 3, 2015 at 10:21 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > On Thu, 2015-07-30 at 12:55 -0400, Dan Williams wrote:
> >> Update memremap_pmem() to query the architecture for the mapping type of
> >> the given persistent memory range  and then pass those flags to generic
> >> memremap().  arch_memremap_pmem_flags() is provided an address range to
> >> evaluate in the event an arch has a need for different mapping types by
> >> address range.  For example the ACPI NFIT carries EFI mapping types in
> >> its memory range description table.
> >>
> >> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
