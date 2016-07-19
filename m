From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Jul 2016 10:49:54 -0400
Subject: [PATCH V10 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <20160718182448.7b11a7af@t450s.home>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
 <1468883367-2854-5-git-send-email-okaya@codeaurora.org>
 <20160718180049.78db3dfb@t450s.home>
 <b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
 <20160718182448.7b11a7af@t450s.home>
Message-ID: <73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2016 8:24 PM, Alex Williamson wrote:
>>> nit, might make sense to replace EPERM with ENOENT and use EINVAL here.
>>> > >   
>> > 
>> > Sure, will take carr of it.
>> > 
>> > Anything else I need to take care of?
> Not that I see, maybe just send a new version of this patch if the
> changes don't trickle through too much.  Thanks,

I posted V11 with the discussed change. 

[PATCH V11 0/9] vfio, platform: add ACPI support

Do you see this making to 4.8 kernel?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
