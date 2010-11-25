From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Nov 2010 11:13:29 +0000
Subject: [PATCH] ASoC: fix SND_PXA2XX_LIB Kconfig warning
In-Reply-To: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
References: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20101125111329.GC22298@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 12:46:15AM +0300, Dmitry Artamonow wrote:
> Fix following warning observed when SND_PXA2XX_SOC is set and SND_ARM isn't:
> 
> warning: (SND_PXA2XX_AC97 && SOUND && !M68K && SND && SND_ARM && ARCH_PXA ||
> SND_PXA2XX_SOC && SOUND && !M68K && SND && SND_SOC && ARCH_PXA) selects
> SND_PXA2XX_LIB which has unmet direct dependencies (SOUND && !M68K && SND &&
> SND_ARM)
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Applied, thanks.
