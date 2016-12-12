From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Dec 2016 21:18:46 +0100
Subject: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
In-Reply-To: <20161212191651.GV14217@n2100.armlinux.org.uk>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
 <20161209200729.GO14217@n2100.armlinux.org.uk>
 <87bmwhdrx7.fsf@free-electrons.com>
 <20161212191651.GV14217@n2100.armlinux.org.uk>
Message-ID: <20161212211846.12db0b3c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 12 Dec 2016 19:16:51 +0000, Russell King - ARM Linux wrote:

> I'd send something, but I don't know what the GIC interrupt number
> would be without using the CP110's ICU (which isn't supported in
> mainline yet.)

For now, mainline relies on a static mapping of CP interrupts to GIC
interrupts, via an ICU configuration done in ATF. It's pretty
straightforward to figure out the CP interrupts to GIC interrupt
mapping if you have access to the ATF source code. If you don't, I can
provide the necessary details.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
