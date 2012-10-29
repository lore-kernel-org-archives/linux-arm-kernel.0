From: alexandre.belloni@piout.net (Alexandre Belloni)
Date: Mon, 29 Oct 2012 22:28:26 +0100
Subject: [PATCH] at91sam9m10g45-ek: rename leds to match board
In-Reply-To: <20121029161445.GB31214@game.jcrosoft.org>
References: <1351279752-6491-1-git-send-email-alexandre.belloni@piout.net>
 <20121027145132.GJ18964@game.jcrosoft.org>
 <20121029150038.GA4995@piout.net>
 <20121029161445.GB31214@game.jcrosoft.org>
Message-ID: <20121029212826.GA6203@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, Oct 29, 2012 at 05:14:45PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote :
> No here it's different teh same HW have different revision
> 
> m10g45es
> m10ekes
> 9g45ekes
> 
> the m10ekes is the first one and the leds does match
> 
> So I agree we can put a comment in the c or the dts about it but do not change
> the content as the board support is like this for really long time
> And I do not want to ebd-up with 2 or 3 dts jsut for lesd naming
> That I will have to maintain
> 

>From my discussion with atmel last week, I understood that the only
publicly available board is the m10g45ek. Support for the other boards
you mention is actually being dropped and you can't find them on ATMEL's
website anymore.

So, I agree you should support only one configuration but at least, let
it be the one for the current board.

Regards,

-- 
Alexandre Belloni
