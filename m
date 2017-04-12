From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 12 Apr 2017 11:44:02 -0500
Subject: [PATCH 3/8] arm64: defconfig: enable TCG_TPM and TCG_CRB
In-Reply-To: <20170412160907.GA7153@leverpostej>
References: <1492012980-11650-1-git-send-email-timur@codeaurora.org>
 <1492012980-11650-4-git-send-email-timur@codeaurora.org>
 <20170412160907.GA7153@leverpostej>
Message-ID: <48f219e0-4ead-a6c5-d657-1801de2c37de@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 11:09 AM, Mark Rutland wrote:
> I see there are patches queued in linux-next enabling some arm64 TPM CRB
> support, which I believe are related.
> 
> As I have commented elsewhere [1], I think those have been taken
> prematurely, and I'm not sure it's a good idea to enable this just yet,
> due to that. There are spec issues to be addressed in the draft that is
> still open.
> 
> [1] https://lkml.kernel.org/r/20170411113652.GB32267 at leverpostej

Ok, I will drop this patch in v2.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
