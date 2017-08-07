From: davem@davemloft.net (David Miller)
Date: Mon, 07 Aug 2017 14:14:48 -0700 (PDT)
Subject: [PATCH v9 0/4] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <588b378c-249a-36b0-8890-769258fbb708@huawei.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <20170806.204744.1934067595236180060.davem@davemloft.net>
 <588b378c-249a-36b0-8890-769258fbb708@huawei.com>
Message-ID: <20170807.141448.1388035794329323595.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Mon, 7 Aug 2017 12:13:17 +0800

> Hi David?
> 
> I think networking tree merge it is a better choice, as it mainly used to tell the NIC
> drivers how to use the Relaxed Ordering Attribute, and later we need send patch to enable
> RO for ixgbe driver base on this patch. But I am not sure whether Bjorn has some of his own
> view. :)
> 
> Hi Bjorn:
> 
> Could you help review this patch or give some feedback ?

I'm still waiting on this...

Bjorn?
