From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 4 Dec 2017 09:49:41 -0600
Subject: [PATCH v4] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <2b252975-bf1f-7468-071e-f4a4aa2430a0@codeaurora.org>
References: <1512397671-28733-1-git-send-email-awallis@codeaurora.org>
 <9cb2e5fc-1bec-c19c-c04e-fe56e5c1bc16@codeaurora.org>
 <2b252975-bf1f-7468-071e-f4a4aa2430a0@codeaurora.org>
Message-ID: <674b566f-bc82-8b07-a632-a9705e1db96f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2017 09:48 AM, Adam Wallis wrote:
> As noted in the patch description, xhci-plat devices will use a default of
> 40,000, while MTK devices will use a default of 5,000. This is also documented
> in the probe for each relevant driver. This is further confirmed in the
> description for each driver's binding TXT file.

Serves me right for reviewing patches before I've had my morning coffee.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
