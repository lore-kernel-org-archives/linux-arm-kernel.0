From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 13:36:23 +0000
Subject: [PATCH 3/3] ASoC: EDB93xx machine sound driver
In-Reply-To: <1291809834.31916.5.camel@r60e>
References: <1291809834.31916.5.camel@r60e>
Message-ID: <20101208133622.GG16418@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 03:03:54PM +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for EDB93xx sound with CS4271 codec.
> Features:
> - Playback, Capture
> - Sample rates from 8kHz to 96kHz tested
> Limitations:
> - Depends on ALSA auto sample format conversion
> - No DAPM support

This looks good.
