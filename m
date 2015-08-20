From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 20 Aug 2015 10:22:36 -0500
Subject: [PATCH 3/3] [v2] hvc_dcc: disable user-space access to DCC
In-Reply-To: <20150820104645.GD19328@arm.com>
References: <1440025370-9519-1-git-send-email-timur@codeaurora.org>
 <1440025370-9519-3-git-send-email-timur@codeaurora.org>
 <20150820104645.GD19328@arm.com>
Message-ID: <55D5F0BC.4010304@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2015 05:46 AM, Will Deacon wrote:
>> If the DCC driver loads, then disable user-space access to the DCC so that
>> >we don't have two entities trying to access the DCC at the same time.

> In the interests of making some headway with this, just drop this patch
> and I'll queue the diff below via the arm64 tree.

Yes, that would be great.  Thank you.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
