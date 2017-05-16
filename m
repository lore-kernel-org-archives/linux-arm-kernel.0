From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Tue, 16 May 2017 11:16:21 -0600
Subject: [PATCH V16 08/11] efi: print unrecognized CPER section
In-Reply-To: <20170516165540.xnbxdhrqeiorqhc5@pd.tnic>
References: <1494883680-25551-1-git-send-email-tbaicar@codeaurora.org>
 <1494883680-25551-9-git-send-email-tbaicar@codeaurora.org>
 <20170516142927.guxwc3gdgpqshpks@pd.tnic>
 <5a4a5b58-3e31-9fa5-091d-bb63437da9ab@codeaurora.org>
 <20170516165540.xnbxdhrqeiorqhc5@pd.tnic>
Message-ID: <e91cb902-c583-c3bc-b5d8-bd4291581341@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/16/2017 10:55 AM, Borislav Petkov wrote:
> On Tue, May 16, 2017 at 10:44:43AM -0600, Baicar, Tyler wrote:
>> I meant to respond to this comment after I sent the v16 patch series, but
>> you beat me to it :)
>>
>> These prefixes are common to all the GHES/CPER printing to the kernel logs.
> I don't mean that - I meant to remove them from this particular example
> in the commit message along with the timestamps. Because they are simply
> useless there.
>
> Of course they should stay in the actual printk calls.
Ah, okay. I'll remove all that from the commit message.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
