From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 15 Nov 2016 16:36:34 +0000
Subject: [PATCH v5 6/8] Documentation: bindings: add compatible specific
 to legacy SCPI protocol
In-Reply-To: <4e31f1d9-61b9-53a9-bd0c-dd5e452faece@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
 <20161110012249.ed56ik6kdffoikym@rob-hp-laptop>
 <14e563ae-36c5-4bf9-0d51-3b07830de3db@arm.com>
 <CAL_JsqLW4JZHb0ncVUEefnKySA231EDgvCkY3xPdaJGf=uMJYg@mail.gmail.com>
 <7ccc12bc-9a05-47e3-8ab8-d1b0ad31159e@arm.com>
 <CAOesGMj3TYLkvfGbq6BKqr+9i6mjArjRPuqeAN1-rGO2OhoSyw@mail.gmail.com>
 <ed58424e-e538-227a-37b5-b35fbe4f96ba@arm.com>
 <CAL_JsqJ5PxzM_VMP55m+6snkqyWSMSsdCOiUzYWkMTb3LkD5Mw@mail.gmail.com>
 <4e31f1d9-61b9-53a9-bd0c-dd5e452faece@arm.com>
Message-ID: <88a5a995-05fc-2369-be00-805469b8e853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/11/16 14:19, Sudeep Holla wrote:
>
>
> On 11/11/16 13:34, Rob Herring wrote:
>> On Fri, Nov 11, 2016 at 1:48 AM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:

[...]

>>>
>>> True and I agree, how about "arm,scpi-pre-1.0" instead ?
>>
>> That's still meaningless. Convince me that multiple implementations
>> are identical, then we can have a common property. For example, how
>> many releases did ARM make before 1.0.
>>
>
> None officially, so I tend to agree with you on this.
>
> But so far we have seen some commonality between Rockchip and Amlogic
> implementations, which in fact shares some commonality with early
> release of SCPI from ARM (there are based on the same SCP code base,
> which is closed source and released to partners only). ARM improved the
> specification and the code base before the official release but by then
> it was adopted(as usual we were late ;))
>
> IMO, it's might be useful to have more generic say "arm,scpi-pre-1.0"
> and platform specific "amlogic,meson-gxbb-scpi"
>

Rob and Olof, is it convincing enough reason to have generic compatible?
Or you prefer to drop it ?

I prefer to have "arm,scpi-pre-1.0". IMO it's useful, let me know. I
need to send PR as it's getting late now.

-- 
Regards,
Sudeep
