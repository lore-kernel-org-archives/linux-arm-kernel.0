From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 14:06:14 +0100
Subject: Which is better to specify console, "console= " or "stdout-path" ?
In-Reply-To: <56278CF3.9010400@hurleysoftware.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
 <562753A6.3070107@arm.com> <56278911.9050704@hurleysoftware.com>
 <56278AFD.8000505@arm.com> <56278CF3.9010400@hurleysoftware.com>
Message-ID: <56278DC6.8090601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 14:02, Peter Hurley wrote:
> On 10/21/2015 08:54 AM, Sudeep Holla wrote:
>> On 21/10/15 13:46, Peter Hurley wrote:

[..]

>>> Be aware that options specified via /chosen/stdout-path are
>>> currently ignored by earlycon. There were some hiccups getting the
>>> initial support upstream; when 4.4 hits mainline, I'll resubmit
>>> my series that implements the of_serial i/o properties and
>>> options passthrough to earlycon setup.
>>>
>>
>> Yes I am aware of that.
>
> The others to which my email was addressed might not know that.
>

True, good that you pointed it out.

>> IIUC it's in -next now and works fine for me.
>
> Well, the fix in -next doesn't actually do anything wrt earlycon baud
> rate; those changes were part of a larger series that depends on
> the fix in -next.
>

Ah ok.

-- 
Regards,
Sudeep
