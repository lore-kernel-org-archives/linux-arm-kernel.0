From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 13:07:41 +0100
Subject: [alsa-devel] [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
In-Reply-To: <1869072.QQLATNzYYx@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<3289863.m6ULFZUV3p@wuerfel> <004e01cc8198$848347f0$8d89d7d0$@com>
	<1869072.QQLATNzYYx@wuerfel>
Message-ID: <20111003120741.GD23811@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 01:50:08PM +0200, Arnd Bergmann wrote:

> the patch. The other problem in this patch is still there, with
> CONFIG_SND_SOC_SMDK_WM8994_PCM=y and CONFIG_MFD_WM8994=n:

You've not sent a seprate patch for that one yet...
