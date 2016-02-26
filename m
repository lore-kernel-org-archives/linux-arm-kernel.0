From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 17:23:45 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: enable useful configurations for
 Vybrid
In-Reply-To: <1455156652-6950-1-git-send-email-stefan@agner.ch>
References: <1455156652-6950-1-git-send-email-stefan@agner.ch>
Message-ID: <3925334.GbIll3VaQm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 18:10:52 Stefan Agner wrote:
> Enable configuration options useful for Vybrid:
> - NFC NAND driver
> - USB dual-role controller (and Chipidea Gadget support)
> - Built-in EDMA DMA driver (to be available at LPUART probe)
> - Vybrid ADC driver
> - IIO hwmon support (used in i.MX 23/28, patch pending for Vybrid)
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 

I've applied this to the next/defconfig branch in arm-soc directly now.

I think it wasn't completely clear what should happen to this when Olof
picked up all other patches and pull requests. I'd recommend to send
patches like this one through the normal platform maintainers instead,
or if that doesn't work make sure that arm at kernel.org is on the
recipient list.

	Arnd
