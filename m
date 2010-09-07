From: pieterg@gmx.com (pieterg)
Date: Tue, 7 Sep 2010 13:09:15 +0200
Subject: colibri-pxa300: LCD_LDD / LCD_CS gpio conflict
In-Reply-To: <AANLkTinhN-Yz1CMQ78zXSNjjqL-GB1VrBTVKU6A=K9gq@mail.gmail.com>
References: <201009061512.23705.pieterg@gmx.com>
	<201009071115.46721.pieterg@gmx.com>
	<AANLkTinhN-Yz1CMQ78zXSNjjqL-GB1VrBTVKU6A=K9gq@mail.gmail.com>
Message-ID: <201009071309.15413.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 September 2010 11:50:08 Eric Miao wrote:
> On Tue, Sep 7, 2010 at 5:15 PM, pieterg <pieterg@gmx.com> wrote:
> > How about using GPIO127_LCD_CS_N instead? Then at least we won't have a
> > conflict with the LDD pins.
> > I don't know why the conflicting GPIO62_LCD_CS_N was chosen in the
> > first place?
>
> That depends on hardware, it's not like whichever pin with functionality
> of LCD_CS_N can be used. Need to check with schematics if the LCD_CS_N
> signal is routed to GPIO62 or GPIO127.

GPIO127 is available on the colibri connector (as well as 62 of course), but 
on the evalboard, there is no LCD_CS_N support (neither GPIO62 nor 
GPIO127).

Rgds, Pieter
