From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 8 Apr 2011 19:14:09 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <BANLkTi=DiGX=yg9HAxYHwKdOvedJdYC_sw@mail.gmail.com>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTin1yyow595tcYveB5fh8q3x+U_GOw@mail.gmail.com>
	<BANLkTi=DiGX=yg9HAxYHwKdOvedJdYC_sw@mail.gmail.com>
Message-ID: <BANLkTinCFnFELn_BPFWE+WCHtZB7d0o1gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/8 Rafa? Mi?ecki <zajec5@gmail.com>:
> 2011/4/8 Rafa? Mi?ecki <zajec5@gmail.com>:
>> Could you say something more about *class*, please? For my BCM43224 it
>> seems to be 0x0. WIll check BCM4313 in a moment.
>
> Same for BCM4313.
>
> BCM43224:
> axi: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x22, class 0x0)
> axi: Core 1 found: IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x17, class 0x0)
> axi: Core 2 found: PCIe (manuf 0x4BF, id 0x820, rev 0x0F, class 0x0)
>
> BCM4313
> axi: Core 0 found: ChipCommon (manuf 0x4BF, id 0x800, rev 0x24, class 0x0)
> axi: Core 1 found: IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x18, class 0x0)
> axi: Core 2 found: PCIe (manuf 0x4BF, id 0x820, rev 0x11, class 0x0)

This is last one, really ;)

This is MMIO dump (from wl):
R 4 92.541328 1 0xfaafc000 0x4bf80001 0x0 0
R 4 92.541351 1 0xfaafc014 0x4bf81201 0x0 0
R 4 92.541373 1 0xfaafc028 0x4bf82001 0x0 0

So there is not any mistake in my reading code. This the youngest 0x1
is SCAN_ER_VALID.

-- 
Rafa?
