From: denis@eukrea.com (Denis Carikli)
Date: Tue, 10 Jun 2014 12:41:59 +0200
Subject: [PATCH RFT RESEND] ARM: dts: imx51-eukrea-mbimxsd51-baseboard:
 Use simple-audio-card for sound
In-Reply-To: <1402063103-6315-1-git-send-email-shc_work@mail.ru>
References: <1402063103-6315-1-git-send-email-shc_work@mail.ru>
Message-ID: <5396E0F7.3010000@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 03:58 PM, Alexander Shiyan wrote:
> This patch replaces usage of special driver for sound with simple-audio-card.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
> I ask Eukrea developers to test this.
[...]

When I add CONFIG_SND_SIMPLE_CARD=y, I have that in dmesg:
platform snd-soc-mbimxsd51.0: baudclk is missing which is necessary for 
master mode
fsl-ssi-dai 70014000.ssi: simple-card: set_fmt error
asoc-simple-card sound: ASoC: failed to init 
70014000.ssi-tlv320aic23-hifi: -22
asoc-simple-card sound: ASoC: failed to instantiate card -22
asoc-simple-card: probe of sound failed with error -22
[...]
ALSA device list:
   No soundcards found.

Denis.
