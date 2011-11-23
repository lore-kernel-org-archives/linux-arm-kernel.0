From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 23 Nov 2011 23:51:44 +0400
Subject: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
Message-ID: <20111123195144.GB9918@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:45 Wed 23 Nov     , Paul Parsons wrote:
> Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
> in SPI slave mode. The driver implements a simple navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
> touchpad is mapped to the ENTER button.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---

Both patches look good to me. Sadly, I can't test them as Navpoint on my
hx4700 is broken for a long time :(

BTW, it's funny that driver is placed in input/mouse, but actually
reports only keyboard events :)
Anyway, reporting coordinates can be added at some later point.

-- 
Best regards,
Dmitry "MAD" Artamonow
