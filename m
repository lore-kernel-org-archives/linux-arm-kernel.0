From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 24 Apr 2017 13:02:58 -0500
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <c3dfaceb-41ba-b13d-f47e-a279c3e2f6b9@oracle.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
 <4b58d5ab-c924-97af-728f-b9f524e62a53@oracle.com>
 <CAK8P3a0cVMt3y_oYH70V-ekPvUMeeBApSvybpRftSupzYy1FWQ@mail.gmail.com>
 <e2f9efab-291f-1436-2176-0fff3f2aae3f@oracle.com>
 <CAK8P3a1mPgM4XmS398DPsSbyCyD=12xQfUrF_HRqyd52_21o7Q@mail.gmail.com>
 <c3dfaceb-41ba-b13d-f47e-a279c3e2f6b9@oracle.com>
Message-ID: <c97828b4-7f19-93d1-6f23-d86e089cea87@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 04:54 PM, Santosh Shilimkar wrote:
> +Dave,
>
> On 4/21/2017 2:44 PM, Arnd Bergmann wrote:
>> On Fri, Apr 21, 2017 at 11:02 PM, santosh.shilimkar at oracle.com
>> <santosh.shilimkar@oracle.com> wrote:
>>> On 4/21/17 2:31 AM, Arnd Bergmann wrote:
>
> [...]
>
>>>> arm-soc/next/drivers:
>>>> ae3874cc931b ARM: keystone: Drop PM domain support for k2g
>>>> 52835d59fc6c soc: ti: Add ti_sci_pm_domains driver
>>>> 7cc119f29b19 dt-bindings: Add TI SCI PM Domains
>>>> 213ec7fed302 PM / Domains: Do not check if simple providers have phandle
>>>> cells
>>>> a5ea7a0fcbd7 PM / Domains: Add generic data pointer to genpd data struct
>>>>
>>> Above are the correct git object for which I sent pull request for.
>>
>> Ok, good, thanks for checking! They are however the commits that
>> contain the silly https://urldefense.proofpoint.com URLs. Can you
>> send a follow-up patch to fix these and use the regular
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.ti.org&d=DwIBaQ&c=RoP1YumCXCgaWHvlZYR8PQcxBKCX5YTpkKY057SbK10&r=XBn1JQGPwR8CsE7xpP3wPlG6DQU7qw8ym65xieNZ4hY&m=vFHOEb7p2FxbH00YRQq4WnRiu2BKHADn0gl6e6DoNFQ&s=7mfiIp2Ywy9_ppWKjEGlrswiKRndv8_I7zGVF9uyT0w&e=
>>
>> URL that is in linux-next?
>>
> Dave,
> Any reason you changed these URLs in last version ?
> Can you please fixup these URLs to along with DT defines.

I didn't change any of the URLs in the patches, I am not sure what those URLs 
are. In the patches I sent the URLs are fine, and I see them normal on patchwork 
too: https://patchwork.kernel.org/patch/9660785/

Is there something that automatically changes those? I don't want to send 
another patch for it to just get mangled again.

Regards,
Dave

>
> Regards,
> Santosh
