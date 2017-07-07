From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Jul 2017 09:31:09 -0400
Subject: [PATCH] PCI: Do not enable extended tags on pre-dated (v1.x)
 systems
In-Reply-To: <CANE52Ki_B0pitpyNMBjrtEJBX6Cspe8-m3hZuEFCWuBN2osh-g@mail.gmail.com>
References: <1499260748-21860-1-git-send-email-okaya@codeaurora.org>
 <CANE52Ki_B0pitpyNMBjrtEJBX6Cspe8-m3hZuEFCWuBN2osh-g@mail.gmail.com>
Message-ID: <c5e37c83-a43d-257a-fa2f-50fdab29ce7a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2017 1:04 AM, Jike Song wrote:
> Maybe checking the version of this endpoint at first? Do you expect a
> v1 endpoint
> to be working under v2+ ports?

I see your point. I guess we need to validate both incoming and outgoing.
I was only checking incoming direction. 

Let me look at this one more time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
