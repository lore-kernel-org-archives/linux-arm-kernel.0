From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Jan 2011 13:45:13 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <20110123154607.GC30094@n2100.arm.linux.org.uk>
References: <20110114120229.GA15996@n2100.arm.linux.org.uk>
	<1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
	<1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
	<20110114163520.GH15996@n2100.arm.linux.org.uk>
	<1295024327.7901.70.camel@e102109-lin.cambridge.arm.com>
	<20110114173050.GJ15996@n2100.arm.linux.org.uk>
	<AANLkTin_pMzNc-ZL+rVcwaVawer0poyxhatqw5P-A2qW@mail.gmail.com>
	<20110115154019.GF15996@n2100.arm.linux.org.uk>
	<AANLkTim8OhAtqADck0Snq-7z7opw=coiQ4=DeO0O7Qa-@mail.gmail.com>
	<20110123154607.GC30094@n2100.arm.linux.org.uk>
Message-ID: <1295963113.10109.255.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-01-23 at 15:46 +0000, Russell King - ARM Linux wrote:
> So, here's the revised patch.  Ack?

Apart from the itttt instruction, it looks fine. So once we agree on
that, you can add my Ack.

-- 
Catalin
