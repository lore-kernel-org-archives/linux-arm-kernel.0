From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 09:48:45 -0800
Subject: [PATCH v2] ARM: dts: sbc-t3x: add DVI display data
In-Reply-To: <54561E45.7000404@compulab.co.il>
References: <1413364186-23752-1-git-send-email-lifshitz@compulab.co.il>
 <1414927198-7127-1-git-send-email-lifshitz@compulab.co.il>
 <54561E45.7000404@compulab.co.il>
Message-ID: <20141110174845.GP31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [141102 04:08]:
> On 11/02/14 13:19, Dmitry Lifshitz wrote:
> > Add DSS related pinmux and display data nodes required to support
> > DVI video out on SBC-T3530, SBC-T3730 and SBC-T3517.
> > 
> > Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks applying into omap-for-v3.19/dt.

Are we now ready to drop the board-cm-*.c files?

Regards,

Tony
