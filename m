From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 18 Oct 2016 08:05:05 -0700
Subject: [PATCH V3 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
In-Reply-To: <20161018140543.GE18903@localhost>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-3-git-send-email-okaya@codeaurora.org>
 <20161018140543.GE18903@localhost>
Message-ID: <84372578-eb80-249f-01ef-b16f4a18a0fb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2016 7:05 AM, Bjorn Helgaas wrote:
> I think you should squash patches 2 & 3 and not bother with trying to
> make this a revert followed by a fix.  Squashing them makes the git
> history much easier to follow, plus you don't have to deal with the
> headache of ensuring the intermediate state is correct and bisectable.

OK. I can do that.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
