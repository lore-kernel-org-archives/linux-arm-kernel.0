From: davem@davemloft.net (David Miller)
Date: Sun, 20 Sep 2015 21:44:21 -0700 (PDT)
Subject: [PATCH v2 0/5] net: Hisilicon Network Subsystem support
In-Reply-To: <1442472710-20909-1-git-send-email-huangdaode@hisilicon.com>
References: <1442472710-20909-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <20150920.214421.16012758847156956.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: huangdaode <huangdaode@hisilicon.com>
Date: Thu, 17 Sep 2015 14:51:45 +0800

> This is V2 of Hisilicon Network Subsystem(HNS) patchesets taking care
> about LKML comments.
> 
> Please find out the changes from the change logs. 
> This patchset is rebased on mainline kernel Linux 4.3-rc1 branch.
> 
> [PATCH v2 1/5] Device Tree Binding Documentation
> [PATCH v2 2/5] Merge MDIO Module
> [PATCH v2 3/5] Hisilicon Network Acceleration Engine Framework
> [PATCH v2 4/5] Distributed System Area Fabric Module
> [PATCH v2 5/5] Basic Ethernet Driver Module
> 
> Changes from V1:
> 1. Remove "inline" in C file (according to LKML comment, same in below).
> 2. Fix a bug about class_find_device.
> 3. Change the DTS pattern on hnae, restruct it to compatible with Hi1610 soc.
> 4. Unified hip04_mdio and hip05_mdio into hns_mdio, which is more usaul for 
>    later SOCs.
> 
> V1 Patches Reference: https://lkml.org/lkml/2015/8/14/165

Series applied, thanks.

 
