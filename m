From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 18 Jun 2013 23:35:57 +0200
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <20130618213344.GA1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1494539.CqPx2jpKaT@flatron> <20130618213344.GA1926@mithrandir>
Message-ID: <1693766.5Dkqfh4vQE@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 of June 2013 23:33:45 Thierry Reding wrote:
> On Tue, Jun 18, 2013 at 08:13:51PM +0200, Tomasz Figa wrote:
> > On Wednesday 19 of June 2013 03:06:31 Kukjin Kim wrote:
> > > On 06/19/13 02:59, Tomasz Figa wrote:
> > > > Hi Thierry,
> > > 
> > > [...]
> > > 
> > > >>> +static void pwm_samsung_set_divisor(struct samsung_pwm_chip
> > > >>> *pwm,
> > > >>> +					unsigned int channel, u8 
divisor)
> > > >> 
> > > >> Nit: please align arguments on subsequent lines with the first
> > > >> argument
> > > >> of the first line. There's many more of these but I haven't
> > > >> mentioned
> > > >> them all explicitly.
> > > > 
> > > > Hmm, I'm addressing all your comments that aren't addressed yet in
> > > > v2
> > > > at the moment and I'm wondering if this is really the correct way
> > > > of
> > > > breaking function headers...
> > > 
> > > static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> > > 
> > > 				    unsigned int channel, u8 divisor)
> > > 
> > > I also would preferred to use above style :)
> > 
> > Personally I find it looking better as well, but this is about being
> > compliant with kernel coding style guidelines (which also says that
> > indentation should be done using tabs). Please correct my
> > understanding of the quote below if it is incorrect.
> 
> "placed substantially to the right" doesn't imply right-aligned. My
> understanding is that it should be indented enough to make it stand
> apart. I don't recall ever seeing right-aligned code.
> 
> And regarding tabs, you should be indenting using tabs as far as
> possible and use spaces for the final alignment, so:
> 
> static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> 				    unsigned int channel, u8 divisor)
> 
> In case your emailer doesn't highlight it, that's four tabs and four
> spaces.

OK. Thank you for clearing up my misunderstanding.

Btw. I see it as spaces-only in my mail client somehow.

Best regards,
Tomasz
