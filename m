From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Feb 2012 19:49:04 +0100
Subject: [PATCH 0/3] pinctrl: move the core per-device handlers to core
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178EF838ED@HQMAIL01.nvidia.com>
References: <1328814050-22715-1-git-send-email-linus.walleij@linaro.org>
 <4F34A3EF.3070207@nvidia.com>
 <CACRpkdZ0kTXLAfdsfMjeZZX4W-fx5zyEdeGboKCmKSzCaMVw_A@mail.gmail.com>
 <4F360853.3050402@nvidia.com>
 <CACRpkdYm3sb7wbJP1M9HmjkGHq1YuT06ar6-+V1RoZ1QdoT9BA@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178EF838ED@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdbL9DbJ7pMVabjOqw6HeWY5N-u7JmK3TdzQVvpZgy0RNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 9:01 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Monday, February 13, 2012 12:48 PM:
>>
>> I'm mainly thinking if the underlying driver may be subject to change I
>> could just keep it out-of-tree, unless you want it merged in for some
>> practical reason, then I'll just merge it.
>
> IIRC, people hoped that the common pinctrl bindings would make it into
> 3.4. If that happens, the driver won't be unused in 3.4.
>
> I don't foresee any changes to the driver except those driven by any
> changes to the core pinctrl itself, so I don't foresee any need to keep
> it out of tree.

OK however since the patches no longer mess around in arch/arm/mach-*
I guess it's OK if I just throw it on the top of my patch queue with
everything else rather than as a separate branch?

I'll do that for now, tell me if it causes any problems!

Yours,
Linus Walleij
