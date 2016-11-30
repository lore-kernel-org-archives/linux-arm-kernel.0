From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 30 Nov 2016 16:29:35 +0000
Subject: [PATCH] arm64: dts: juno: Correct PCI IO window
In-Reply-To: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
References: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <92ac8013-b88e-2f74-9a49-7d5f38a4e7a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 29/11/16 20:45, Jeremy Linton wrote:
> The PCIe root complex on Juno translates the MMIO mapped
> at 0x5f800000 to the PIO address range starting at 0
> (which is common because PIO addresses are generally < 64k).
> Correct the DT to reflect this.
>

I have another DT fix that I have asked ARM-SoC guys to pick up directly
from the list. If that doesn't happen, I will send PR including both.

If that happens then we need to send this to them to be picked directly.
At this point I want to wait for couple of days to avoid confusion.

-- 
Regards,
Sudeep
