From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Jul 2014 17:03:57 -0400 (EDT)
Subject: [PATCH v6] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <CAM4voa=K6s0FFmeuiqWZh6HSQZAfSpxL8A_kMTxCi+2t3tzydw@mail.gmail.com>
References: <alpine.LFD.2.11.1407041408120.22282@knanqh.ubzr>
 <CAM4voamqpCj=Zw69DGjzhouwu=6RE6e3Px5WL8akc-TUAts0Xg@mail.gmail.com>
 <CAM4voa=K6s0FFmeuiqWZh6HSQZAfSpxL8A_kMTxCi+2t3tzydw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407041702310.22282@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Jul 2014, Abhilash Kesavan wrote:

> On a different note, I have been using the cpuidle patchset
> (https://patchwork.kernel.org/patch/4357421/) as base for S2R support
> and had a question. Rather than making the driver depend on
> ARCH_EXYNOS should it depend on EXYNOS5420_MCPM which in turn depends
> on MCPM (like TC2) or should we just be making the bL cpuidle driver
> depend on MCPM ?

Probably making it depend on MCPM directly is the best approach.


Nicolas
