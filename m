From: martinwguy@gmail.com (Martin Guy)
Date: Tue, 6 Apr 2010 22:28:53 +0100
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100406181839.GA2685@gw.healthdatacare.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
Message-ID: <x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>  I only have one ep9302 board and 2 SPI devices

If you'd like one of the MMC-only boards to test on, I can ship it to
you - please provide smail mail address by private mail if that would
be welcome

>  > Lastly, what is the meaning of conditional operator(s) in
>  >         return t->bits_per_word ?: msg->spi->bits_per_word;
>  > It compiles, but it's the first time I've seen this construct in 27
>  > years of C programming. What is the "normal" syntax for this?
>
> It is an GCC extension:
>
>  http://gcc.gnu.org/onlinedocs/gcc-4.4.3/gcc/Conditionals.html#Conditionals
>
>  I've been using it once I saw it somewhere in the kernel source.

OK, I suggest we don't use "GNU extensions" if they can be avoided,
and program in C. The GCC monoculture is ending, thanks to llvm. and
those gnu-heads are not the most wise people on the planet. (OK, the
ANSI committe are worse, but.... :)

   M
