From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 23 Nov 2018 11:34:34 +0900
Subject: [PATCH 9/9] eisa: consolidate EISA Kconfig entry in drivers/eisa
In-Reply-To: <20181115190538.17016-10-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-10-hch@lst.de>
Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

I locally fixed the commit log (HAS_EISA -> HAVE_EISA)
so that it matches to the code.

Thanks.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---

--
Best Regards
Masahiro Yamada
