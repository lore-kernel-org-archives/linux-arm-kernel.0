From: lukma@denx.de (Lukasz Majewski)
Date: Wed, 13 Dec 2017 09:52:57 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <1513153607.2439.2.camel@Nokia-N900>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
Message-ID: <20171213095257.5cf424fb@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander, Linus

> Hello Linus!
> 
> On Wed Dec 13 08:34:22 2017 Linus Walleij <linus.walleij@linaro.org>
> wrote:
> > On Tue, Dec 12, 2017 at 12:36 AM, Lukasz Majewski <lukma@denx.de>
> > wrote: Out of curiosity: Liebherr is obviously doing heavy-duty
> > industrial control systems. Likewise Hartley is doing similar
> > business over at Vision Engravings.
> > 
> > Is the situation such that there is a whole bunch of industrial
> > systems out there, in active use and needing future upgrades,
> > that use the EP93xx?  
> 
> That's definitely the case. I'm as well aware of several thousands of
> industrial devices which are expected to run 24/7 for the next 5
> years at least. And they are updated from time to time.

I can agree with this statement. 

> 
> > Arnd has been nudging me to do DT conversion for EP93xx
> > so if there are many active industrial users of these
> > I should prioritize it, because these things have 20+ years
> > support cycles.  
> 
> I'm not sure how important or necessary at all is to change anything
> in these legacy platforms.

+1

> 
> > We also need to think about upholding support in GCC for
> > ARMv4(t) for the foreseeable future if there is a big web of
> > random deeply embedded systems out there that will need
> > updates.  
> 
> But we should definitely preserve at least what we have.

I'm using OE to build toolchain (SDK). I can confirm that gcc 7.2 works
with it.

And yes, armv4 support shall be preserved in GCC ....

> 
> --
> Alexander.
> 



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/d6dfd68c/attachment-0001.sig>
