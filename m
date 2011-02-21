From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Feb 2011 21:49:07 +0100
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
	<AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
	<AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
	<AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com>
Message-ID: <AANLkTimE5xK8RgNiP+9D2D_beBcbWhBNSzjnhEU36GTO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Out of sheer curiosity, Qualcomm/CodeAurora guys:

if you dump out the registers at offset 0xfe0-0xfff on the
SDCC, does it contain a valid PrimeCell ID? Anyone who
can make a hexdump of it?

It is possible to hardcode an AMBA ID to use this driver
even if this area is just 0x0000... but I'm just curious
about how different silicon vendors treat these registers,
e.g. if they contain something sensible.

Yours,
Linus Walleij
