From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 28 Apr 2014 22:46:10 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVNvQzogZnNsOiBzZWxlY3QgU05EX1NPQ19JTVhfUENN?=
 =?UTF-8?B?X0RNQSB3aGVyZSBuZWVkZWQ=?=
In-Reply-To: <6606961.lAGLvkNsEj@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel>
Message-ID: <1398710770.235891074@f303.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 28 Apr 2014 16:46:30 +0200 ?? Arnd Bergmann <arnd@arndb.de>:
> Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> manually. However, these two options are for drivers that both
> require the imx-pcm-dma framework and result in a link error if that
> is not provided.
> 
> This changes Kconfig to automatically select SND_SOC_IMX_PCM_DMA
> to avoid the problem, as we do for other drivers that need the same
> framework.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Can you give an exact error?

---
