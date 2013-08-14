From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 13 Aug 2013 17:18:07 -0700
Subject: arm-soc: Xilinx Zynq DT changes for v3.12
In-Reply-To: <87r4dxfbuk.fsf@kernel.org> (Kevin Hilman's message of "Tue, 13
 Aug 2013 15:46:27 -0700")
References: <520A47C3.5000106@monstr.eu> <87r4dxfbuk.fsf@kernel.org>
Message-ID: <87ioz9dt1c.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@linaro.org> writes:

> Hi Michal,
>
> Michal Simek <monstr@monstr.eu> writes:
>
>> Hi Arnd and Olof,
>
> I'm now helping out with arm-soc maintenance as well, and am on the
> arm at kernel.org alias, so thanks for Cc'ing it.
>
>> please pull this simple DT change to your tree.
>
> Pulled into next/dt.
>
> In the future, it makes things simpler for us if you base on older -rc
> releases where possible (c.f. similar request by Olof[1].)  In this
> case, it was trivial for me to rebase it onto -rc1 so I've done that
> before applying.

Looking closer (thanks to Olof), since your tree is already in
linux-next, my rebasing this would cause problems in -next, so I can't
rebase it.

Either you can rebase it to an earlier -rc (preferred), or I can pull in
-rc5 into next/dt (which is currently causing an unrelated conflict
which I'll have to deal with tomorrow.)

Kevin
