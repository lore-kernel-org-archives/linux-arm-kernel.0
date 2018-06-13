From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2018 11:08:10 +0200
Subject: [PATCH 2/3] rtc: ftrtc010: handle dates after 2106
In-Reply-To: <20180604141528.15635-2-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
 <20180604141528.15635-2-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdbt=2diDRueUqdEnHxViG-Nr0Rcs-aW67hjgrQnxQUaAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 4, 2018 at 4:15 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use correct types for offset and time and use
> rtc_time64_to_tm/rtc_tm_to_time64 to handle dates after 2106 properly.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
