From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Apr 2014 10:56:53 -0700
Subject: [PATCH 0/4] Support qcom GDSC hardware
In-Reply-To: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
References: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <534D72E5.1000805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 11:45, Stephen Boyd wrote:
> These patches add support for the multimedia GDSCs on the
> apq8074 dragonboard. The first two patches (and potentially the last)
> should go through Mike's tree and the DTS patch should go through
> the qcom tree. Patches are based on v3.14. The probe will conflict with
> patches I sent to consolidate things. I'll rework these patches on top of
> that if the gdsc.c file is acked/reviewed.

Any comments?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
