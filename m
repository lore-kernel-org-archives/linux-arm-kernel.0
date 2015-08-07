From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 06 Aug 2015 21:40:14 -0700
Subject: [PATCH] ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE
In-Reply-To: <1438914158-12439-1-git-send-email-gregory.0xf0@gmail.com>
References: <1438914158-12439-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <55C436AE.6070704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/15 19:22, Gregory Fong a ?crit :
> Broadcom STB (BRCMSTB) has some 64-bit capable DMA and therefore needs
> dma_addr_t to be a 64-bit size.  One user is the Broadcom SATA3 AHCI
> controller driver.
> 
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

Applied to soc/next, thanks Gregory!
-- 
Florian
