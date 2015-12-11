From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 00:57 +0100
Subject: [GIT PULL] arm64: DTS changes for X-Gene platforms queued for v4.5
In-Reply-To: <CADaLNDnM463bnMq349q_2XEh2AeGs4yrp-y474wQZ-NCSE0Cqw@mail.gmail.com>
References: <CADaLNDnM463bnMq349q_2XEh2AeGs4yrp-y474wQZ-NCSE0Cqw@mail.gmail.com>
Message-ID: <4175975.EH46H1lqut@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 10:20:50 Duc Dang wrote:
> DTS changes for X-Gene platforms queued for v4.5
> 
> This patch set adds DTS entries to support various IPs
> for X-Gene v1 and X-Gene v2 SoC:
> - X-Gene v1: Enable support for MMC, USB, GPIO controllers,
>   I2C controller, L2 Cache topology
> - X-Gene v2: Enable support for MMC, USB, GPIO controller,
>   I2C controller (with RTC), PCIe controller with GICv2m MSI,
>   EDAC, L2 Cache topology, TRNG
> 

Merged into next/dt64.

I see that most of your node names are wrong, please fix them
in your next update by using the standard node names:

	dwusb -> usb
	i2c0 -> i2c
	cfggpio0 -> gpio
	dwgpio -> gpio
	...

	Arnd
