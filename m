From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sun, 26 Feb 2012 12:04:55 +0100
Subject: [PATCH v3] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <1327967449.72659.YahooMailClassic@web29002.mail.ird.yahoo.com>
References: <1327967449.72659.YahooMailClassic@web29002.mail.ird.yahoo.com>
Message-ID: <CA+gwMccFY1KLn4=cHPkO-dOHz1+8EdPcc=FaCJ0hL5+uMYVEew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 12:50 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The hx4700 platform has 72 board gpios: 64 ASIC3 gpios numbered 192..255, and
> 8 EGPIO gpios numbered 256..263 (plus a 9th which is not used).
> Thus the new CONFIG_ARCH_NR_GPIO config option must be set to 264.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
