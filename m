From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 12 Dec 2017 16:57:22 -0600
Subject: How to debug "insecure W+X mapping"?
Message-ID: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 4.10-based kernel that occasionally displays an insecure W+X 
mapping (courtesy of CONFIG_DEBUG_WX):

[    7.151680] arm64/mm: Found insecure W+X mapping at address 
0000345a049d2000/0x345a049d2000
...
[    7.435481] Checked W+X mappings: FAILED, 4 W+X pages found, 0 
non-UXN pages found

The number of actual W+X pages varies, e.g. sometimes it says 6 pages.

How do I go about debugging this? How do I identify the source of 
0000345a049d2000?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
