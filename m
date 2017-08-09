From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 9 Aug 2017 20:11:33 +0000
Subject: [PATCH v9 1/4] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
In-Reply-To: <20170809180007.GA9100@otc-nc-03>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
 <20170808232200.GO16580@bhelgaas-glaptop.roam.corp.google.com>
 <20170809155841.GA8675@otc-nc-03>
 <MWHPR12MB1600E9D94E74E1DECC192097C88B0@MWHPR12MB1600.namprd12.prod.outlook.com>,
 <20170809180007.GA9100@otc-nc-03>
Message-ID: <MWHPR12MB1600471F60D862E5788B8439C88B0@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Wednesday, August 9, 2017 11:00 AM
|
| On Wed, Aug 09, 2017 at 04:46:07PM +0000, Casey Leedom wrote:
| > | From: Raj, Ashok <ashok.raj@intel.com>
| > | Sent: Wednesday, August 9, 2017 8:58 AM
| > | ...
| > | As Casey pointed out in an earlier thread, we choose the heavy hammer
| > | approach because there are some that can lead to data-corruption as
| > | opposed to perf degradation.
| >
| > Careful.  As far as I'm aware, there is no Data Corruption problem
| > whatsoever with Intel Root Ports and processing of Transaction Layer
| > Packets with and without the Relaxed Ordering Attribute set.
|
| That's right.. no data-corruption on Intel parts :-).. It was with other
| vendor. Only performance issue with intel root-ports in the parts identified
| by the optimization guide.

Yes, I didn't want you to get into any trouble over that possible reading of
what you wrote.

Any progress on the "Chicken Bit" investigation?  Being able to disable the
non-optimal Relaxed Ordering "optimization" would be the best PCI Quirk of
all ...

Casey
