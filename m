From: monstr@monstr.eu (Michal Simek)
Date: Wed, 14 Aug 2013 07:50:01 +0200
Subject: arm-soc: Xilinx Zynq DT changes for v3.12
In-Reply-To: <87ioz9dt1c.fsf@kernel.org>
References: <520A47C3.5000106@monstr.eu> <87r4dxfbuk.fsf@kernel.org>
 <87ioz9dt1c.fsf@kernel.org>
Message-ID: <520B1A89.8080704@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 02:18 AM, Kevin Hilman wrote:
> Kevin Hilman <khilman@linaro.org> writes:
> 
>> Hi Michal,
>>
>> Michal Simek <monstr@monstr.eu> writes:
>>
>>> Hi Arnd and Olof,
>>
>> I'm now helping out with arm-soc maintenance as well, and am on the
>> arm at kernel.org alias, so thanks for Cc'ing it.
>>
>>> please pull this simple DT change to your tree.
>>
>> Pulled into next/dt.
>>
>> In the future, it makes things simpler for us if you base on older -rc
>> releases where possible (c.f. similar request by Olof[1].)  In this
>> case, it was trivial for me to rebase it onto -rc1 so I've done that
>> before applying.
> 
> Looking closer (thanks to Olof), since your tree is already in
> linux-next, my rebasing this would cause problems in -next, so I can't
> rebase it.

That's correct but as you probably noticed this branch is not merged
to linux-next. (Only arm-next branch is added there). I want ask Stephen
for removing this branch anyway.

> 
> Either you can rebase it to an earlier -rc (preferred), or I can pull in
> -rc5 into next/dt (which is currently causing an unrelated conflict
> which I'll have to deal with tomorrow.)

I wasn't aware about using earlier -rc. The last information I got
is that these trees should be based on Linux -rc (or tagged if you like) version.
I will keep this in my mind and will use earlier versions in the next pull requests.

It is just one single patch and I believe you have to use rc5
and resolve that all conflicts anyway that's why it is just question
of time when you have to deal with it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/e0093f9b/attachment.sig>
