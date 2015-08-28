From: agross@codeaurora.org (Andy Gross)
Date: Fri, 28 Aug 2015 12:19:04 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3-rc2
In-Reply-To: <20150828001603.GO13472@usrtlx11787.corpusers.net>
References: <1440710899-29214-1-git-send-email-agross@codeaurora.org>
 <20150828001603.GO13472@usrtlx11787.corpusers.net>
Message-ID: <20150828171903.GA7886@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 05:16:03PM -0700, Bjorn Andersson wrote:
> On Thu 27 Aug 14:28 PDT 2015, Andy Gross wrote:
> 
> > The following changes since commit 72af1ff60d08a57e223b9753f9c52396fb4c3897:
> > 
> >   Merge tag 'qcom-soc-for-4.3' into for-soc-new (2015-08-27 12:14:29 -0500)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3-rc2
> > 
> > for you to fetch changes up to 3427446d72e21f6992534a3b68055f1b4c722546:
> > 
> >   soc: qcom: smd: Use correct remote processor ID (2015-08-27 12:15:58 -0500)
> > 
> > ----------------------------------------------------------------
> > Qualcomm ARM Based SoC Updates for 4.3-rc2
> > 
> > * Fix errant private access in SMEM
> > * Fix use of correct remote processor ID in SMD transactions
> > 
> 
> I was hoping to see my fBLOCKREADINTR fix [1] here as well, as the issue
> it's fixing it a never ending stall if we're trying to send data with a
> full tx fifo - i.e. a rather bad result...
> 
> But I'm fine with you queuing it for -rc3 too...
> 
> [1] https://lkml.org/lkml/2015/8/24/756
> 
> Regards,
> Bjorn

Ack, sorry.  I'll resend it after bumping the subject

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
