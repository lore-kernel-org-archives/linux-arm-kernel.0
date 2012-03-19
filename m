From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Mon, 19 Mar 2012 09:31:55 +0100
Subject: [PATCH] pxa/hx4700: fix the LCD initialization
In-Reply-To: <1331995717.82481.YahooMailClassic@web29016.mail.ird.yahoo.com>
References: <1331905213.29979.1.camel@flow>
 <1331995717.82481.YahooMailClassic@web29016.mail.ird.yahoo.com>
Message-ID: <CA+gwMcd14LVxF=pxyewQRDFUfTFxhmnTzHmxSF=_s2kJyxn5EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sat, Mar 17, 2012 at 3:48 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> After some experimenting it seems that neither GPIO110 "LCD_LVDD_3V3_ON"
> nor GPIO112 "LCD_N2V7_7V3_ON" have any effect on the hx4700 LCD.
> After the hx4700 boots I can turn either one off, or both off together,
> and the LCD and touchscreen will continue to work normally.
>
> Is there an authoritative description of the 7 "LCD" GPIOs (GPIO59,
> GPIO62, GPIO70, GPIO84, GPIO110, GPIO111, GPIO112) that are used by
> the kernel, or the 2 "LCD" GPIOs (GPIO22, GPIO73) that are not used?
> The SDG code provides no enlightenment.

that is a good question. Not having done any of the reverse
engineering for hx4700 myself, I've always taken the SDG code as
gospel.
Unfortunately I am not aware of any hx4700 hardware schematics or even
a datasheet for the acx523akm lcd panel.

regards
Philipp
