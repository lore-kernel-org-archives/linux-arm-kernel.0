From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Thu, 13 Apr 2017 15:33:13 -0600
Subject: [PATCH V14 02/10] ras: acpi/apei: cper: generic error data entry
 v3 per ACPI 6.1
In-Reply-To: <20170413204744.iizyyi32v4hjt3fc@pd.tnic>
References: <1490729440-32591-1-git-send-email-tbaicar@codeaurora.org>
 <1490729440-32591-3-git-send-email-tbaicar@codeaurora.org>
 <20170412133447.n2yft7v266v6k6gh@pd.tnic>
 <8a31ef45-68f6-d444-f174-4a485cccd696@codeaurora.org>
 <20170413204744.iizyyi32v4hjt3fc@pd.tnic>
Message-ID: <faa953d1-61bd-4b53-af0d-1980d9b55d68@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2017 2:47 PM, Borislav Petkov wrote:
> On Thu, Apr 13, 2017 at 02:30:21PM -0600, Baicar, Tyler wrote:
>> I do not agree with this. The struct being passed to this function is
>> already named acpi_hest_generic_data in the existing code and all over this
>> code is named gdata not just d.
> And I'm saying they're too long - the preexisting ones and the ones
> you're adding - and impair readability. This whole driver is one
> unreadable ugly pile and if I were the maintainer I would never allowed
> it in its current form.
>
> But I don't think it really has a maintainer - poor Rafael has to deal
> with it because it is under drivers/acpi/ and that whole RAS firmware
> crap got thrown over the wall at some point and now we're stuck with it.
>
> So this is just my opinion since he asked me to take a look.
Okay, that makes sense. I'd prefer to avoid completely re-writing the 
existing code in this patch set :)

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
