From: ross.zwisler@linux.intel.com (Ross Zwisler)
Date: Wed, 29 Jul 2015 13:12:36 -0600
Subject: [PATCH v2 22/25] pmem: switch from ioremap_wt to memremap
In-Reply-To: <20150725024001.8664.13362.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024001.8664.13362.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <1438197156.17072.0.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-24 at 22:40 -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_wt() convert its usage in
> the PMEM API to memremap.
> 
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Ross Zwisler <ross.zwisler@linux.intel.com>
