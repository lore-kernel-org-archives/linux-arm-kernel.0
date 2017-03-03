From: ashok.raj@intel.com (Raj, Ashok)
Date: Fri, 3 Mar 2017 09:05:51 -0800
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
In-Reply-To: <1488534044.6234.14.camel@infradead.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
 <1488534044.6234.14.camel@infradead.org>
Message-ID: <20170303170550.rj7awy4jjfiw6qgd@araj-mobl1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Good to hear back from you!


On Fri, Mar 03, 2017 at 09:40:44AM +0000, David Woodhouse wrote:
> 
> Intel slightly deviates from the "one PASID per process" vision too,
> because it currently has a PASID allocator idr per IOMMU. That wants
> making system-wide. And probably not Intel-specific.

Intel version is getting the system wide pasid. We are actively working on it
and should be out shortly.

> 
> Some other comments...
> 
> We also have SVM_FLAG_SUPERVISOR_MODE, which gives access to kernel
> address space. Yes, people use it.

There are some gaps with the current implementation, esp related to 
vmalloc. We have something internally, these will also be posted soon after
some testing. 

Cheers,
Ashok
