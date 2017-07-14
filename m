From: leedom@chelsio.com (Casey Leedom)
Date: Fri, 14 Jul 2017 00:00:07 +0000
Subject: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>,
 <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
Message-ID: <MWHPR12MB16004FB4E5A3DFB5B8D87876C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[ Sorry for the Double Send: I forgot to switch to Plain Text.  Have I mentioned how much I hate modern Web-based email agents? :-) -- Casey ]]

? Yeah, I think this works  for now.? We'll stumble over what to do when we want to mix upstream  TLPs without Relaxed Ordering Attributes directed at problematic Root  Complexes, and Peer-to-Peer TLPs with Relaxed Ordering Attributes ... or vice versa depending on which target PCIe Device has  issues with Relaxed Ordering.

? Thanks for all the work!

Casey    
