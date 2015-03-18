From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 18 Mar 2015 14:53:16 -0700
Subject: [PATCH] dt-bindings: brcm: rationalize Broadcom documentation
 naming
In-Reply-To: <5509D528.1080208@wwwdotorg.org>
References: <1426706645-19313-1-git-send-email-sbranden@broadcom.com>
 <5509D528.1080208@wwwdotorg.org>
Message-ID: <5509F3CC.1010207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 15-03-18 12:42 PM, Stephen Warren wrote:
> On 03/18/2015 01:24 PM, Scott Branden wrote:
>> This patchset attempts to standarize the naming of dt-bindings
>> documents based on the Broadcom vendor prefix of brcm.
>>
>> Although there are no guidelines currently present for how to name
>> the dt-bindings document the "vendor,binding.txt" style is in use by
>> some of the other vendors.
>
> Conceptually I'm fine with this.
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> The only comment I have is that some bindings refer to other bindings,
> e.g. an I2C controller binding might refer to the core I2C binding to
> define core I2C properties. Since this patch moves a couple files
> between directories, did you double-check that none of the pathnames in
> those references need fixing up?

Yes, I read all the brcm documents and did not find references to the 
moved files.

In my search I found 4 more files inconsistently named from the Kona 
family.  I'm submitting a new patch with those files renamed as well.

Thanks,
Scott
