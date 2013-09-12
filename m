From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Sep 2013 11:53:47 -0500
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
 <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
Message-ID: <25E0B143-658E-4CCC-A88A-0AF70FFF33CE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 12, 2013, at 11:46 AM, Olof Johansson wrote:

> On Thu, Sep 12, 2013 at 9:37 AM, Kumar Gala <galak@codeaurora.org> wrote:
>> Use the Qualcomm vendor prefix (qcom) as the directory name for
>> Qualcomm MSM devicetrees going forward.
>> 
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> 
> Let's not move just one platform like this. If we are to do this, we
> should move everything, and that will be really painful and needs to
> be done in a controlled manner, probably scripted and right before a
> -rc1 or such.


Than I suggest we deal with it when we pull the device trees out of the kernel tree.

As such, I'd tell Rohit to go forward with the file being named apq8074-dragonboard.dtb for the time being.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
