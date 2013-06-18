From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 18 Jun 2013 20:13:51 +0200
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <51C0A1A7.60309@samsung.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1430661.RSssKEDPJD@flatron> <51C0A1A7.60309@samsung.com>
Message-ID: <1494539.CqPx2jpKaT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 of June 2013 03:06:31 Kukjin Kim wrote:
> On 06/19/13 02:59, Tomasz Figa wrote:
> > Hi Thierry,
> 
> [...]
> 
> >>> +static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> >>> +					unsigned int channel, u8 divisor)
> >> 
> >> Nit: please align arguments on subsequent lines with the first
> >> argument
> >> of the first line. There's many more of these but I haven't mentioned
> >> them all explicitly.
> > 
> > Hmm, I'm addressing all your comments that aren't addressed yet in v2
> > at the moment and I'm wondering if this is really the correct way of
> > breaking function headers...
> 
> static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> 				    unsigned int channel, u8 divisor)
> 
> 
> I also would preferred to use above style :)

Personally I find it looking better as well, but this is about being 
compliant with kernel coding style guidelines (which also says that 
indentation should be done using tabs). Please correct my understanding of 
the quote below if it is incorrect.

Best regards,
Tomasz

> 
> - Kukjin
> 
> > According to Documentation/CodingStyle:
> > 
> > /* Quotation starts */
> > Statements longer than 80 columns will be broken into sensible chunks,
> > unless exceeding 80 columns significantly increases readability and
> > does not hide information. Descendants are always substantially
> > shorter than the parent and are placed substantially to the right.
> > The same applies to function headers with a long argument list.
> > However, never break user- visible strings such as printk messages,
> > because that breaks the ability to grep for them.
> > /* Quotation ends */
> > 
> > Do I understand this incorrectly or does the above fragment state that
> > broken lines must be aligned to the right?
> > 
> > Best regards,
> > Tomasz
