From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Jan 2016 19:08:50 +0000
Subject: iommu/arm-smmu-v2 ASID/VMID calculation
In-Reply-To: <E0484253-BE37-476A-9F4A-ABE6B74EC174@caviumnetworks.com>
References: <198F501C-8D30-4EB5-BC40-4F40BB75D40B@caviumnetworks.com>
 <20160125170312.GJ22927@arm.com>
 <E978AB4F-5CB0-42D8-8152-04C77DB664A1@caviumnetworks.com>
 <6F24A28A-6302-4C48-A933-B47A9735808C@caviumnetworks.com>
 <20160126115435.GB21553@arm.com>
 <E0484253-BE37-476A-9F4A-ABE6B74EC174@caviumnetworks.com>
Message-ID: <20160127190849.GF25545@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 07:06:48PM +0000, Chalamarla, Tirumalesh wrote:
> On 1/26/16, 3:54 AM, "Will Deacon" <will.deacon@arm.com> wrote:
> >The problem is that you have shared state between multiple SMMU instances,
> >which I don't think is correct. I'm fine with a workaround, but I don't
> >want this logic to be used on other implementations where it is not
> >needed.
> 
> Ok, I will treat it as Errata and provide a patch for workaround this. 

Thank you.

Will
