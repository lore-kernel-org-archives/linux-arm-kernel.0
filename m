From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Apr 2015 16:49:49 +0100
Subject: [PATCH v7 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <552BB14A.6010205@samsung.com>
References: <1426637856-3730-1-git-send-email-cw00.choi@samsung.com>
 <1426637856-3730-2-git-send-email-cw00.choi@samsung.com>
 <20150330160940.GA13731@leverpostej> <5519E2B6.2030905@samsung.com>
 <20150402173558.GB30669@leverpostej> <551DD321.6030707@samsung.com>
 <20150407102523.GA23190@leverpostej>
 <20150413105618.GD4076@leverpostej> <552BB14A.6010205@samsung.com>
Message-ID: <20150413154949.GI4076@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>> So NAK to the PSCI node and PSCI enable method in this dts until we
> >>>> either have a working firmware, or a reasonable mechanism to handle the
> >>>> deficiency.
> >>>
> >>> There is only CPU0 hotplug issue. Excpet CPU{1-7} are well working.
> >>
> >> I understand that, but the issue with CPU0 is still a blocker from my
> >> PoV.
> >>
> >>> To fix this issue, we must need the help of firmware developer.
> >>> But, We never get the any help.
> >>
> >> Previously you said that you did not have access to the source code
> >> rather than not having help from the relevant firmware engineers. I take
> >> it you have informed them of the issue with CPU0?
> 
> I didn't ask any help to firmware engineer because I didn't know who firmware engineer
> and also didn't access the source code. If I knew the engineer and can access them,
> I would have asked some help to them or inquired the reason about CPU0 not hotplugged.

You must have acquired the firmware (or board(s) with the firmware
preloaded) from somewhere. Surely you can work backwards from there to
file a bug report and/or inquire as to who you need to speak to...

Mark.
