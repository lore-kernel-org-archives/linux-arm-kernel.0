From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 29 Oct 2012 17:14:45 +0100
Subject: [PATCH] at91sam9m10g45-ek: rename leds to match board
In-Reply-To: <20121029150038.GA4995@piout.net>
References: <1351279752-6491-1-git-send-email-alexandre.belloni@piout.net>
 <20121027145132.GJ18964@game.jcrosoft.org>
 <20121029150038.GA4995@piout.net>
Message-ID: <20121029161445.GB31214@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:00 Mon 29 Oct     , Alexandre Belloni wrote:
> On Sat, Oct 27, 2012 at 04:51:32PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote :
> > On 21:29 Fri 26 Oct     , Alexandre Belloni wrote:
> > > The leds' name in the board file didn't match the names written on the
> > > board itsef. This can be confusing when trying to use them for another
> > > purpose.
> > 
> > It like this for so long time and I'm not really willing to touch the dts
> > 
> 
> I don't think any real application is build on the assumption that each
> pins are wrongly named. But, for newcomers, it can get really confusing,
> especially as the led triggers are compiled as module in the defconfigs
> and the LEDs won't turn on until you load the module. 
> 
> It just boils down to wanting to improve the usability of the
> development board or not.
No here it's different teh same HW have different revision

m10g45es
m10ekes
9g45ekes

the m10ekes is the first one and the leds does match

So I agree we can put a comment in the c or the dts about it but do not change
the content as the board support is like this for really long time
And I do not want to ebd-up with 2 or 3 dts jsut for lesd naming
That I will have to maintain

Best Regards,
J.
