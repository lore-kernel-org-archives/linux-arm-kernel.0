From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Sat, 5 Jul 2014 02:52:53 +0530
Subject: [PATCH v6] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <alpine.LFD.2.11.1407041702310.22282@knanqh.ubzr>
References: <alpine.LFD.2.11.1407041408120.22282@knanqh.ubzr>
 <CAM4voamqpCj=Zw69DGjzhouwu=6RE6e3Px5WL8akc-TUAts0Xg@mail.gmail.com>
 <CAM4voa=K6s0FFmeuiqWZh6HSQZAfSpxL8A_kMTxCi+2t3tzydw@mail.gmail.com>
 <alpine.LFD.2.11.1407041702310.22282@knanqh.ubzr>
Message-ID: <CAM4voamyswvgoH7c9ryPXxEtOv4ZHgyuAbuxC6v2FzM6PiMFrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Sat, Jul 5, 2014 at 2:33 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sat, 5 Jul 2014, Abhilash Kesavan wrote:
>
>> On a different note, I have been using the cpuidle patchset
>> (https://patchwork.kernel.org/patch/4357421/) as base for S2R support
>> and had a question. Rather than making the driver depend on
>> ARCH_EXYNOS should it depend on EXYNOS5420_MCPM which in turn depends
>> on MCPM (like TC2) or should we just be making the bL cpuidle driver
>> depend on MCPM ?
>
> Probably making it depend on MCPM directly is the best approach.
I'll discuss this with Chander and one of us will post a patch for it.

Regards,
Abhilash
>
>
> Nicolas
