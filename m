From: leedom@chelsio.com (Casey Leedom)
Date: Mon, 14 Aug 2017 18:07:51 +0000
Subject: [PATCH v10 3/5] PCI: Disable Relaxed Ordering Attributes for AMD
 A1100
In-Reply-To: <20170814171937.GA52656@otc-nc-03>
References: <1502725499-11276-1-git-send-email-dingtianhong@huawei.com>
 <1502725499-11276-4-git-send-email-dingtianhong@huawei.com>,
 <20170814171937.GA52656@otc-nc-03>
Message-ID: <MWHPR12MB1600654CA840BC47AFC06127C88C0@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Monday, August 14, 2017 10:19 AM
| ?   
| On Mon, Aug 14, 2017 at 11:44:57PM +0800, Ding Tianhong wrote:
| > Casey reported that the AMD ARM A1100 SoC has a bug in its PCIe
| > Root Port where Upstream Transaction Layer Packets with the Relaxed
| > Ordering Attribute clear are allowed to bypass earlier TLPs with
| > Relaxed Ordering set, it would cause Data Corruption, so we need
| > to disable Relaxed Ordering Attribute when Upstream TLPs to the
| > Root Port.
| > 
| > Signed-off-by: Casey Leedom <leedom@chelsio.com>
| > Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
| > Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
| > Acked-by: Ashok Raj <ashok.raj@intel.com>
| 
| I can't ack this patch :-).. must be someone from AMD. Please remove my
| signature from this.

  You can go ahead and leave my name on since I'm the person who found and diagnosed the problem (with help from others inside Chelsio).

  If anyone on the Linux PCI List knows anyone at AMD who'd be willing to respond it would be great, but as I noted earlier, I think that AMD has effectively abandoned the A1100 ("Seattle") ARM SoC, so I doubt if we'll get anyone from AMD to even comment now.

Casey
