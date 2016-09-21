From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 21 Sep 2016 13:34:44 -0400
Subject: [PATCH V6 0/5] ECAM quirks handling for ARM64 platforms
In-Reply-To: <20160921173129.GA20006@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <20160920192636.GB4941@localhost>
 <0429663d51ed8e93fb0c96261dd2ecc7@codeaurora.org>
 <20160921131107.GB10804@localhost>
 <25529f96-3e80-0524-82d8-6eeb517df5b5@codeaurora.org>
 <20160921173129.GA20006@localhost>
Message-ID: <3137f181-1c23-ca56-fbca-b2cdbabd784b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2016 1:31 PM, Bjorn Helgaas wrote:
> On Wed, Sep 21, 2016 at 10:07:36AM -0400, Sinan Kaya wrote:
>> On 9/21/2016 9:11 AM, Bjorn Helgaas wrote:
>>> On Tue, Sep 20, 2016 at 09:15:14PM -0400, cov at codeaurora.org wrote:
>>>> Hi Bjorn, Thomasz,
>>>>
>>
>>>>
>>>> Did you delete this because there were no current users, because you'd
>>>> prefer users just use "-1", or for some other reason?
>>>
>>> I removed it because there were no users of it and, more importantly,
>>> the code doesn't implement support for it.
>>
>> Is it possible to queue up Cov's patch as part of this effort once he 
>> rebases and sends an updated version? Cov will have to implement something
>> else now.
> 
> I haven't see Cov's patch (patchwork doesn't follow URLs to git trees,
> and I normally don't either).  If they show up on the mailing list,
> I'll take a look, of course.
> 
> Bjorn
> 

Thanks, I talked to Cov today. He's getting ready to post the rebased patch
once he completes testing.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
