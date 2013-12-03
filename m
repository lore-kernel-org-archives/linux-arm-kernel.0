From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 3 Dec 2013 15:57:14 +0000
Subject: [alsa-devel] [PATCH] ASoC: wm8731: fix dsp mode configuration
In-Reply-To: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
References: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131203155713.GB23979@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 06:04:54PM +0800, Bo Shen wrote:
> According to WM8731 "PD, Rev 4.9 October 2012" datasheet, when it
> works in DSP mode A, LRP = 1, while works in DSP mode B, LRP = 0.
> So, fix LRP for DSP mode as the datesheet specification.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
