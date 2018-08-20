From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Aug 2018 07:21:24 -0700
Subject: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <a69fcb7a-f7a1-481b-8a02-1da7d1e20671@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
 <20180614123805.GF112168@atomide.com>
 <20180614130435.j2bmzam6corrjylx@kahuna>
 <20180615050108.GG112168@atomide.com>
 <a69fcb7a-f7a1-481b-8a02-1da7d1e20671@ti.com>
Message-ID: <20180820142124.GC7523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [180615 13:41]:
> 
> How well we can reuse individual interconnect segments is something I
> have to think about / experiment. Will have to be wary of any "short
> paths" or "cross connections".

These short paths and cross connections are almost certainly just
additional ranges from the parent interconnect. See for example
what we have in Linux next for wdt3 in omap4.dtsi for separate
ranges for L4 and L3 interconnects.

Regards,

Tony
