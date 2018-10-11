From: lkundrak@v3.sk (Lubomir Rintel)
Date: Thu, 11 Oct 2018 18:13:26 +0200
Subject: [PATCH 10/11] spi: pxa2xx: Add ready signal
In-Reply-To: <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-11-lkundrak@v3.sk>
 <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
Message-ID: <a13569d534e4393abff2ac704cee45df2bcd9656.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-10-11 at 09:28 +0200, Geert Uytterhoeven wrote:
> Hi Lubomir,
> 
> On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > Strobe a GPIO line when the slave TX FIFO is filled. This is how
> > the
> > Embedded Controller on an OLPC XO-1.75 machine, that happens to be
> > a SPI
> > master, learns that it can initiate a transaction.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> Thanks for your patch!
> 
> I'm repeating my comments on the RFC below:

Ah, sorry for not addressing those; it somehow slipped through my
fingers. I'll wait a while to collect more feedback before sending v2
and then I'll include fixes for those.

Thanks for the review.

Lubo
