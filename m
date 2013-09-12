From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Sep 2013 12:55:36 -0500
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <CAOesGMhfdvyJ_2AA2e8iO_2e=q7KgpyNbcriPKFw-RLormG6bA@mail.gmail.com>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
 <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
 <25E0B143-658E-4CCC-A88A-0AF70FFF33CE@codeaurora.org>
 <CAOesGMhfdvyJ_2AA2e8iO_2e=q7KgpyNbcriPKFw-RLormG6bA@mail.gmail.com>
Message-ID: <3E38F48E-EE41-4564-84A1-36CF07B08811@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 12, 2013, at 12:06 PM, Olof Johansson wrote:

> On Thu, Sep 12, 2013 at 9:53 AM, Kumar Gala <galak@codeaurora.org> wrote:
>> 
>> On Sep 12, 2013, at 11:46 AM, Olof Johansson wrote:
>> 
>>> On Thu, Sep 12, 2013 at 9:37 AM, Kumar Gala <galak@codeaurora.org> wrote:
>>>> Use the Qualcomm vendor prefix (qcom) as the directory name for
>>>> Qualcomm MSM devicetrees going forward.
>>>> 
>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>> 
>>> Let's not move just one platform like this. If we are to do this, we
>>> should move everything, and that will be really painful and needs to
>>> be done in a controlled manner, probably scripted and right before a
>>> -rc1 or such.
>> 
>> 
>> Than I suggest we deal with it when we pull the device trees out of the kernel tree.
>> 
>> As such, I'd tell Rohit to go forward with the file being named apq8074-dragonboard.dtb for the time being.
> 
> My original request to please use a common prefix for your product
> families stands. Please prefix with msm-*, or if you have to, qcom-*
> instead, since you guys can't seem to make your mind up on standard
> prefixes (msm, apq, etc).

This is silly, I dont see the reason to go with qcom-apq<SOC>-<BOARD>.dts and than in the future drop qcom- when we mostly likely shift to a dir structure.  As engineers we are all too aware of the lack of sanity in marketing names, but its what we have so we have to live with it.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
