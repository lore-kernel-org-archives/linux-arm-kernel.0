From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Feb 2012 10:03:13 +0800
Subject: [PATCH v3 REPOST] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <1330307925.11845.YahooMailClassic@web29010.mail.ird.yahoo.com>
References: <1330307925.11845.YahooMailClassic@web29010.mail.ird.yahoo.com>
Message-ID: <CAN1soZw+Bbcf-Beu_A=Tgg+0kpOu_qBO5EJqYW2FjA7Nou57FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 9:58 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The hx4700 platform has 72 board gpios: 64 ASIC3 gpios numbered 192..255, and
> 8 EGPIO gpios numbered 256..263 (plus a 9th which is not used).
> Thus the new CONFIG_ARCH_NR_GPIO config option must be set to 264.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
Applied

Thanks
Haojian
