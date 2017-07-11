From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 10 Jul 2017 21:41:39 -0400
Subject: [PATCH V2] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
In-Reply-To: <5f5119fd-64d5-5e7c-fa50-54ac6e6a36b6@codeaurora.org>
References: <1499439193-16628-1-git-send-email-okaya@codeaurora.org>
 <20170710230911.GH5610@bhelgaas-glaptop.roam.corp.google.com>
 <5f5119fd-64d5-5e7c-fa50-54ac6e6a36b6@codeaurora.org>
Message-ID: <70e56020-ec7f-9752-7236-7d4157c07205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more question:

On 7/10/2017 8:20 PM, Sinan Kaya wrote:
> Sure, I can change to blacklist. I'll not enable it unless the device is blacklisted
> via quirks.

Since the quirk is at the completer, are you OK with walking the list and clearing the
extended tags across the tree when at least one device with a quirk is found?

Would you look for another solution?

I was told that Linux assumes peer-to-peer is possible by default on another thread.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
