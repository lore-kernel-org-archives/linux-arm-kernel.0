From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 18 Mar 2015 15:08:01 -0700
Subject: [PATCH] dt-bindings: brcm: rationalize Broadcom documentation
 naming
In-Reply-To: <5509F61E.5000702@wwwdotorg.org>
References: <1426706645-19313-1-git-send-email-sbranden@broadcom.com>
 <5509D528.1080208@wwwdotorg.org> <5509F3CC.1010207@broadcom.com>
 <5509F61E.5000702@wwwdotorg.org>
Message-ID: <5509F741.5010206@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15-03-18 03:03 PM, Stephen Warren wrote:
> On 03/18/2015 03:53 PM, Scott Branden wrote:
>> Hi Stephen,
>>
>> On 15-03-18 12:42 PM, Stephen Warren wrote:
>>> On 03/18/2015 01:24 PM, Scott Branden wrote:
>>>> This patchset attempts to standarize the naming of dt-bindings
>>>> documents based on the Broadcom vendor prefix of brcm.
>>>>
>>>> Although there are no guidelines currently present for how to name
>>>> the dt-bindings document the "vendor,binding.txt" style is in use by
>>>> some of the other vendors.
>>>
>>> Conceptually I'm fine with this.
>>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>>>
>>> The only comment I have is that some bindings refer to other bindings,
>>> e.g. an I2C controller binding might refer to the core I2C binding to
>>> define core I2C properties. Since this patch moves a couple files
>>> between directories, did you double-check that none of the pathnames in
>>> those references need fixing up?
>>
>> Yes, I read all the brcm documents and did not find references to the
>> moved files.
>
> Oh, I meant references *from* the moved files to other files.
Yes, some of the moved/renamed files reference other files.  But those 
are to references to common dt-binding documentation files and of the 
form Documentation/devicetree/bindings/xxx/yyy.txt

>
> BTW, I just noticed that both your patches don't have signed-off-by lines.
Whoops - thanks - will have to correct.  Plus, add your Acked-by.
