From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Mon, 18 Jan 2010 14:42:15 +0100
Subject: Use of data types
In-Reply-To: <20100118134120.GB31345@pengutronix.de>
References: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
	<20100118134120.GB31345@pengutronix.de>
Message-ID: <20100118134215.GB16182@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Mon, Jan 18, 2010 at 02:41:20PM +0100 Uwe Kleine-K?nig ha dit:

> On Mon, Jan 18, 2010 at 09:43:12PM +0900, Khushhua Mogambo wrote:
> > Hi
> >   I starting to port Linux kernel to my companies new ARM based
> > SoC and development board.
> > 
> > Some of the regs is 16bits wide and some is 32bits width. I ask if
> > my using u16 and u32 in place of 'unsigned short' and 'unsigned int'
> > in the whole porting would be acceptable or not?
> > 
> > In different wording, using only u16 and u32 always is considered good
> > quality or bad?
> I prefer using u32 over int.  Still more if your register space isn't uniform.

ditto

how about using the C99 types uint32_t, ... in the kernel? 

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

              Insanity: doing the same thing over and over
                again and expecting different results
                            (Albert Einstein)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
