From: ahs3@redhat.com (Al Stone)
Date: Mon, 22 Sep 2014 16:55:48 -0600
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <2486199.jzqMgLksH8@vostro.rjw.lan>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140922194841.GA9868@amd> <20140922203136.GA32156@srcf.ucam.org>
 <2486199.jzqMgLksH8@vostro.rjw.lan>
Message-ID: <5420A8F4.20909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2014 04:46 PM, Rafael J. Wysocki wrote:
> On Monday, September 22, 2014 09:31:36 PM Matthew Garrett wrote:
>> On Mon, Sep 22, 2014 at 09:48:41PM +0200, Pavel Machek wrote:
>>> On Fri 2014-09-12 22:00:16, Hanjun Guo wrote:
>>>> +No code shall be accepted into the kernel unless it complies with the released
>>>> +standards from UEFI ASWG. If there are features missing from ACPI to make it
>>>> +function on a platform, ECRs should be submitted to ASWG and go through the
>>>> +approval process.
>>>
>>> Surely this should be narrowed down somehow? Or is reading all the
>>> released standards from ASWG mandatory before patching the kernel now?
>>>
>>> Spelling out wtf ECR is would be nice, too.
>>
>> Explicit Change Request.

Actually, it's "Engineering Change Request" -- a standard document
format used by several of the UEFI working groups, including the ASWG.

 These can only be filed by paid-up members of
>> the UEFI Forum, so I suspect this requirement is going to be unworkable 
>> (there's plenty of ACPI support code for large x86 vendors which isn't 
>> part of any ACPI spec).
> 
> Why do you think so?
> 
> Linux Foundation can do that on behalf of the community if no one else.
> 

Exactly so.  Or, collaborate with the hardware vendor, or a distro
or anyone else that is a Promoter or Contributor as defined by UEFI
[0].  The only thing to keep clear when doing so is who owns the
intellectual property for any proposed change; this is one of the
reasons the UEFI Forum has paid membership levels -- to pay for the
legal assistance to make sure that the specs can be freely used.  As
someone who is part of the ASWG, I'd personally be glad to help out
however I can in this regard.

I'm also curious as to what's being referred to as ACPI support
code for large x86 vendors which is not part of the spec; I *think*
I know what's being described but a specific example would really
help me understand better.

Thanks.



[0] http://www.uefi.org/join

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
