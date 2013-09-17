From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 17 Sep 2013 10:52:02 -0500
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <CAOesGMgCvnuX918pt6vT0_QsHdfJ8b813iu2tXRHvdpL8GZ3dg@mail.gmail.com>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
 <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
 <25E0B143-658E-4CCC-A88A-0AF70FFF33CE@codeaurora.org>
 <CAOesGMhfdvyJ_2AA2e8iO_2e=q7KgpyNbcriPKFw-RLormG6bA@mail.gmail.com>
 <3E38F48E-EE41-4564-84A1-36CF07B08811@codeaurora.org>
 <20130912224737.GA24937@codeaurora.org>
 <9EA264FE-7621-458D-8333-9340DDBFC4EE@codeaurora.org>
 <52374DD1.9040209@codeaurora.org>
 <AEBF64D7-5359-4E37-8263-B81209620192@codeaurora.org>
 <CAOesGMgCvnuX918pt6vT0_QsHdfJ8b813iu2tXRHvdpL8GZ3dg@mail.gmail.com>
Message-ID: <0618B96B-2F6C-4D67-9D32-0B74E898496F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 16, 2013, at 1:50 PM, Olof Johansson wrote:

> On Mon, Sep 16, 2013 at 11:46 AM, Kumar Gala <galak@codeaurora.org> wrote:
> 
>> I think the two options are either:
>> 
>> qcom-msm*, qcom-apq*, etc
>> 
>> or
>> 
>> qcom/msm-*, qcom/apq*, etc
>> 
>> I'm guessing we'll end up without the dir and in the future have:
>> 
>> qcom/qcom-msm-*, qcom/qcom-apq-*
>> 
>> Olof???
> 
> 
> When you create the dir, you can go from qcom-msm-* to qcom/msm-*, but
> still produce qcom-msm-*.dtb as the build output. We care about
> keeping the DTB name stable, not DTS. As long as they just conform to
> those two patterns it's easy to handle through makefile targets.

Sounds good, Rohit let's go ahead with qcom-msm-*, qcom-apq-*.

- k
