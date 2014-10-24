From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 24 Oct 2014 11:04:18 +0200
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <20141024080240.GN32045@tbergstrom-lnx.Nvidia.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
 <20141023081230.GK32045@tbergstrom-lnx.Nvidia.com>
 <CABgxDoKm5kKKCTD1njAerUrM24iVcGRDuhJ7b4qBVPqKBC4ftQ@mail.gmail.com>
 <20141024080240.GN32045@tbergstrom-lnx.Nvidia.com>
Message-ID: <CABgxDoLT7puSr11Xw3D7diGRXj15oktfd7=ATTvjmf2MKKYp0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, will do these changes.

2014-10-24 10:02 GMT+02:00 Peter De Schrijver <pdeschrijver@nvidia.com>:
> On Thu, Oct 23, 2014 at 11:39:34AM +0200, PERIER Romain wrote:
>> Hi Peter,
>>
>> 2014-10-23 10:12 GMT+02:00 Peter De Schrijver <pdeschrijver@nvidia.com>:
>> > This breaks DT ABI stability right? An existing device tree using ti,system-power-controller won't work anymore after this patch right? I don't think that's acceptable.
>> >
>>
>> This is why I converted all dts which use "ti,system-power-controller"
>> and tps65910/tps65911 to the new property (everything is in the
>> patches serie). However, with an existing dtb it will no longer work,
>> yes.
>> What do you suggest ? keep these two properties in the driver ? :/
>>
>
> Yes. Existing DTs should work with new kernels. So there's no other choice
> than leaving support for the existing property in place. Obviously DTs for new
> boards can use the new standardized property.
>
> Cheers,
>
> Peter.
