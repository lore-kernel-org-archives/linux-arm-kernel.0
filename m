From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 09 Jun 2015 08:50:38 +0900
Subject: [PATCHv2 1/2] ARM: exynos_defconfig: Enable
 CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3
In-Reply-To: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
References: <1433696621-4763-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <55762A4E.5090208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.06.2015 02:03, Anand Moon wrote:
> Enable CONFIG_SND_SOC_ODROIDX2 and CONFIG_SND_SIMPLE_CARD to enable
> sound on Odroid-XU3 board.
> 
> Below is the output of boot log.
> [    6.021550] max98090 5-0010: MAX98090 REVID=0x43
> [    6.025506] random: nonblocking pool is initialized
> [    6.047297] asoc-simple-card sound: HiFi <-> 3830000.i2s mapping ok
> [    6.068392] s5m-rtc s2mps14-rtc: setting system clock to 2015-06-07 12:51:06 UTC (1433681466)
> [    6.123650] ALSA device list:
> [    6.135203]   #0: Odroid-XU3

Answering the question "why" and "what is device" would be sufficient.
You answered the first question ("enable sound") so you can just add
second part - using the max98090 audio codec.

This whole dmesg does not bring any benefits here, especially the
irrelevant items (like random or RTC). Could you trim the commit message?

Beside of that it looks fine however you marked this as "v2":
1. I cannot find v1 on Google. The title was the same?
2. Where is changelog?

Best regards,
Krzysztof
