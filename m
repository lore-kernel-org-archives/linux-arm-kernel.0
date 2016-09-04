From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 4 Sep 2016 19:55:55 +0200
Subject: [PATCH 2/2] ARM64: dts: meson-gxbb: add the SDIO pins
In-Reply-To: <20160828191353.wpwbqsxdg5pdmese@vip.cybercity.dk>
References: <20160828164725.19429-1-martin.blumenstingl@googlemail.com>
 <20160828164725.19429-3-martin.blumenstingl@googlemail.com>
 <20160828191353.wpwbqsxdg5pdmese@vip.cybercity.dk>
Message-ID: <CAFBinCBxY8HW26xb1PMdtPfVOAWk3FAQfcU7Qi-ithi==b=y0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 9:13 PM, Rask Ingemann Lambertsen
<ccc94453@vip.cybercity.dk> wrote:
> On Sun, Aug 28, 2016 at 06:47:25PM +0200, Martin Blumenstingl wrote:
>>                               uart_a_pins: uart_a {
>>                                       mux {
>>                                               groups = "uart_tx_a",
>
> You shouldn't use underscores in node names. Use hyphens instead, perhaps.
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
> https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html
The part which you found there is just the context of my patch, not an
actual change.
However, basically all of the GXBB .dts files are using underscores in
the node names.
Do "we" have to change this globally?

Regarding my patch: I got a NACK from Neil Armstrong off-list:
The SDIO IRQ pin is missing in my series.


Regards,
Martin
