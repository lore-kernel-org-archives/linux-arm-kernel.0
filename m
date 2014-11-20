From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Nov 2014 13:25:59 +0000
Subject: 48-bit VA support in the SMMU
In-Reply-To: <7a9f17b997db458b9f15893837df04eb@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <deb48cfb93d94515b6531be02f697e04@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <decb25f05ca84d439e071f6ad8cf0086@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141120100822.GA19126@arm.com>
 <7a9f17b997db458b9f15893837df04eb@BN3PR0301MB1219.namprd03.prod.outlook.com>
Message-ID: <20141120132558.GK19126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 01:05:51PM +0000, Varun Sethi wrote:
> Thanks Will. But still, if things work for the stage 1 case why disable 48
> bit support for the SMMU driver. Wouldn't stage-2 be relevant in case of
> virtual SMMU?

Well, VFIO installs at stage-2 and the host kernel needs to be able to
handle that. The virtual SMMU interface always installs at stage-1.

Will
