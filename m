From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jul 2017 09:03:29 +0100
Subject: ARM v8.2/SMMU v3.1 support
In-Reply-To: <CY1PR07MB216880E869712C948DBE8E1AE3A10@CY1PR07MB2168.namprd07.prod.outlook.com>
References: <CY1PR07MB216880E869712C948DBE8E1AE3A10@CY1PR07MB2168.namprd07.prod.outlook.com>
Message-ID: <20170719080328.GC13642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 12:00:06AM +0000, Kalra, Ashish wrote:
> Is there any work ongoing for SMMU v3.1 & ARM v8.2 extensions for arm-smmu-v3
> iommu driver, mainly
> 
> adding support for 52-bit (ias, oas) addressing on 52-bit PA systems ?

I think Steve (CC'd) has been looking at extending the io-pgtable code to
handle 52-bit addressing. Which other v3.1 features are you interested in?

Will
