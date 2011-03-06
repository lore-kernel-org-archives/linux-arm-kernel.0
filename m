From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 6 Mar 2011 20:02:42 +0100
Subject: [PATCH] ARM: twd: Adjust localtimer frequency withcpufreqnotifiers
In-Reply-To: <AANLkTinRNG4nTjh15a2tuJt_iDboHUtomxemSjY+6DcD@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
	<AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
	<4D70BE9D.4000507@stericsson.com>
	<AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com>
	<4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
	<eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
	<AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
	<7e9fafa016bfe536ccc373fc2cc7ba61@mail.gmail.com>
	<AANLkTinRNG4nTjh15a2tuJt_iDboHUtomxemSjY+6DcD@mail.gmail.com>
Message-ID: <AANLkTikkcYw66MiJO9Bpm+De=XD2-1MFxm-CUPp6sMqL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 6, 2011 at 6:42 PM, Colin Cross <ccross@android.com> wrote:

> Is there any way
> for a clockevent to invalidate the current event and ask for it to be
> reprogrammed?

TGLX will know for sure... Thomas?

(This is inside a CPUfreq hook for a localtimer for the record.)

Yours,
Linus Walleij
