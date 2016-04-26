From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Apr 2016 12:22:49 +0100
Subject: [PATCH v2] drivers: firmware: psci: unify enable-method binding
 on ARM {64, 32}-bit systems
In-Reply-To: <20160426190257.7b2e6a9a@xhacker>
References: <1461338282-19509-1-git-send-email-sudeep.holla@arm.com>
 <571F4632.6090003@arm.com> <31757054.8aSO57qemx@wuerfel>
 <20160426190257.7b2e6a9a@xhacker>
Message-ID: <571F4F89.70006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 26/04/16 12:02, Jisheng Zhang wrote:
> Dear Arnd, Sudeep,
>
> On Tue, 26 Apr 2016 12:49:00 +0200 Arnd Bergmann wrote:
>

[...]

>>
>> Applied to the fixes branch. I have to admit that I don't understand
>> how the compatible string is really used here, so I have to trust that
>> this cannot break any existing machine.
>
> To be honest, this breaks some Marvell DEBU's 32 bit SoCs' kernel, but these

Sorry for that, but it's better to fix it in the firmware/DT.
As I mentioned earlier it was never honored in the kernel before v4.6,
so technically nothing is broken yet :)

> SoCs' support are not mainlined yet, so it's fine to fix it as early as
> possible.
>

Good to hear that. Thanks indeed.

-- 
Regards,
Sudeep
