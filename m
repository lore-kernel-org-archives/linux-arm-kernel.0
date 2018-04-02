From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 2 Apr 2018 15:52:45 -0500
Subject: [PATCH 1/2] pinctrl: qcom: remove static globals to allow
 multiple TLMMs
In-Reply-To: <CACRpkdZ=z7EncPykPwK+m-_qM3J2PokmkcoKsRqao_X1qx7CSg@mail.gmail.com>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZ=z7EncPykPwK+m-_qM3J2PokmkcoKsRqao_X1qx7CSg@mail.gmail.com>
Message-ID: <5133ffa9-0033-249d-ea46-b8972b6e07ac@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 08:33 AM, Linus Walleij wrote:
>> Two data structures are declared as static globals but are intended to
>> be per-TLMM.  Move them into the msm_pinctrl structure and initialize
>> them at runtime.
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>

> Waiting for a review from Stephen or Bjorn on these two
> patches.

Stephen? Bjorn?  I really hope I don't miss the 4.17 release.  I've been 
working on these patches for months.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
