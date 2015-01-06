From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 21:49:21 +0100
Subject: =?UTF-8?B?562U5aSNOg==?= [PATCH v6 17/17] Documentation: ACPI for
 ARM64
In-Reply-To: <D0F5605BA99F0B4594FB1EEC24E785CC654879C3@SZXEMA510-MBX.china.huawei.com>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org>
 <1420368918-5086-18-git-send-email-hanjun.guo@linaro.org>
 <D0F5605BA99F0B4594FB1EEC24E785CC654879C3@SZXEMA510-MBX.china.huawei.com>
Message-ID: <9429675.LhiSR5rsOc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 09:52:05 liyi 00215672 wrote:
> In traditional telecom market, what confused us(Huawei) was our software
> and hardware coupling together oftentimes. So if we change some hardware
> then we MUST modify our software, which was not our customer?s
> expectation. In x86 world, we have UEFI and ACPI technologies, they are
> suitable to solve this problem very well, we just upgrade our hardware
> and don?t need to upgrade their software, in the meantime ACPI provides
> many methods on power management.

Can you give an example of how ACPI solves the problem of supporting a
particular piece of new hardware?

I assume that for a completely new SoC, it won't help because you
still need device drivers for all the major parts of the hardware
that have changed, so this is about parts of the system that can
be abstracted in AML but not fully described in DT without the need
for new device drivers. Which are the main ones you are interested in
here?

	Arnd
