From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 13 Jan 2015 17:44:54 +0000
Subject: [PATCH v3] ASoC: wm8904: fix runtime warning
In-Reply-To: <1421143531-6662-1-git-send-email-voice.shen@atmel.com>
References: <1421143531-6662-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20150113174454.GV14516@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 06:05:31PM +0800, Bo Shen wrote:
> Correct the path name for mux to get rid of the following warning:
> 
> --->8---
> wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTL
> wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTL
> wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTL
> wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTL
> wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTL
> wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTL
> wm8904 1-001a: Control not supported for path ADCL -> [Left] -> AIFOUTR
> wm8904 1-001a: ASoC: no dapm match for ADCL --> Left --> AIFOUTR
> wm8904 1-001a: ASoC: Failed to add route ADCL -> Left -> AIFOUTR
> wm8904 1-001a: Control not supported for path ADCR -> [Right] -> AIFOUTR
> wm8904 1-001a: ASoC: no dapm match for ADCR --> Right --> AIFOUTR
> wm8904 1-001a: ASoC: Failed to add route ADCR -> Right -> AIFOUTR
> wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACL
> wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACL
> wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACL
> wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACL
> wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACL
> wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACL
> wm8904 1-001a: Control not supported for path AIFINR -> [Right] -> DACR
> wm8904 1-001a: ASoC: no dapm match for AIFINR --> Right --> DACR
> wm8904 1-001a: ASoC: Failed to add route AIFINR -> Right -> DACR
> wm8904 1-001a: Control not supported for path AIFINL -> [Left] -> DACR
> wm8904 1-001a: ASoC: no dapm match for AIFINL --> Left --> DACR
> wm8904 1-001a: ASoC: Failed to add route AIFINL -> Left -> DACR
> ---8<---
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
