From: davidb@codeaurora.org (David Brown)
Date: Mon, 17 Jun 2013 13:26:24 -0700
Subject: [GIT PULL 2/3] msm fixes for 3.11
In-Reply-To: <20130615012617.GU18124@quad.lixom.net>
References: <1371232615-30731-1-git-send-email-davidb@codeaurora.org>
 <1371232615-30731-4-git-send-email-davidb@codeaurora.org>
 <20130615012617.GU18124@quad.lixom.net>
Message-ID: <20130617202624.GA23915@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 06:26:17PM -0700, Olof Johansson wrote:

>> Stephen Boyd (3):
>>       ARM: dts: msm: Fix bad register addresses
>
>Hmm. I see that the msm-hsuart device nodes completely lack reg entries. That's
>considerably more important to fix than the cosmetic unit address that's not
>even needed unless two nodes happen to have the same name.

I'm not seeing the missing reg entries in anyone's tree.

However, it appears that both of us resolved the merge conflict
differently, and both did it incorrectly.

How would you like this to be fixed?  Should I just send you a patch
based off of the current soc tree?

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
