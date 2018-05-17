From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 May 2018 11:03:33 +0100
Subject: [PATCH 1/2] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <CACRpkdZgP3whauuV2G3m_eXY9bkQ-waBS0x9Jf91yE6oQE-E_Q@mail.gmail.com>
References: <20180427185404.19205-1-linus.walleij@linaro.org>
 <f8bf7e48-72ab-8749-5d23-32346475a440@arm.com>
 <CACRpkdZgP3whauuV2G3m_eXY9bkQ-waBS0x9Jf91yE6oQE-E_Q@mail.gmail.com>
Message-ID: <a03c16b9-e12e-9fc8-310c-574134a856b6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 17/05/18 10:04, Linus Walleij wrote:
> On Wed, May 9, 2018 at 6:44 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> Please copy me and Lorenzo also in future.
>> Applied now(with typo in hierarchy fixed), thanks.
> 
> Sure thing, sorry I didn't realize you were working actively with
> the Versatile Express, glad to see this :)
> 

I generally send PR to ARM-SoC for Vexpress platforms(mainly
arch/arm/boot/dts/vexpress-*) only not the older Versatile
platforms(arch/arm/boot/dts/versatile-*) :). I know you work
on them more actively.

> I will send you my Versatile Express transition to DRI/DRM series
> today since my Pl111 work for Vexpress is now pending in linux-next,
> if I can find the right commits to base it on, do you have
> a Vexpress git branch somewhere?
> 

I just sent PR[1] to ARM-SoC for v4.18, so you can use that branch/tag
itself for now. Are you planning to get that in for v4.18 ? I can try to
send 2nd PR but not sure of ARM SoC team will be happy since it may be
too late for them.

-- 
Regards,
Sudeep

[1] https://www.spinics.net/lists/arm-kernel/msg652377.html
