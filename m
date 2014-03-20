From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Mar 2014 17:21:00 +0100
Subject: [PATCH] Documentation: dt: list all compatible strings for at91
In-Reply-To: <CAL_Jsq+sctq85ZhqKyVa7=r5A0FEDKu36692rRJufyca1gzF6g@mail.gmail.com>
References: <1395224808-10133-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CAL_Jsq+sctq85ZhqKyVa7=r5A0FEDKu36692rRJufyca1gzF6g@mail.gmail.com>
Message-ID: <20140320162100.GU12021@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 19/03/2014 at 11:14:43 -0500, Rob Herring wrote :
> On Wed, Mar 19, 2014 at 5:26 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Avoids getting the newly introduced warning:
> > WARNING: DT compatible string "atmel,at91sam9g45-adc" appears un-documented -- check ./Documentation/devicetree/bindings/
> > +                               compatible = "atmel,at91sam9g45-adc";
> >
> > Introduced by:
> > bff5da433525 checkpatch: add DT compatible string documentation checks
> 
> We should fix checkpatch instead. There are some fixes in progress,
> but I don't think it covers this issue. I'm puzzled by this one as I
> thought I checked for this case.
> 

Will someone take care of it ? I'm not sure how you want to handle that
as <chip> is replacing different values depending on the context. Also,
while for atmel and freescale, it is replacing the full chip name, that
is not the case for nvidia...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
