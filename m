From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 11 Apr 2018 16:48:54 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180411202616.GA14760@jhogan-linux.mipstec.com>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org>
 <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
 <0f1a4719-9a6f-0df0-7fd9-a25c10e824f5@codeaurora.org>
 <14a663f6-2ea5-230b-2cd0-e42d05d0d7ea@codeaurora.org>
 <20180411202616.GA14760@jhogan-linux.mipstec.com>
Message-ID: <abcad691-2ac8-ffc5-30a2-77ad6781664a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2018 4:26 PM, James Hogan wrote:
> On Wed, Apr 11, 2018 at 01:10:41PM -0400, Sinan Kaya wrote:
>> How is the likelihood of getting this fixed on 4.17 kernel?
> 
> High.
> 

Thanks for the confirmation.

> Thanks
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
