From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 09 Dec 2010 10:08:02 +0000
Subject: [alsa-devel] [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA
	oper. in I2S code
In-Reply-To: <1291856375.31916.94.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291856375.31916.94.camel@r60e>
Message-ID: <1291889282.3271.20.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 03:59 +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changes to I2S code:
> - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
> - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
>   while ALSA will do all sample format translation for us.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
