From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Mar 2013 16:53:21 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3: hwmod data: disable MIDLEMODE control for musb
In-Reply-To: <CANOLnOMUHzbGW-Yz_cXhW1+KNvP-4k6vMDodE94K5G2pwrSf7Q@mail.gmail.com>
References: <1362876391-6801-1-git-send-email-notasas@gmail.com>
 <alpine.DEB.2.00.1303102304490.774@utopia.booyaka.com>
 <CANOLnOMUHzbGW-Yz_cXhW1+KNvP-4k6vMDodE94K5G2pwrSf7Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1303111648370.9211@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gra?vydas,

On Mon, 11 Mar 2013, Grazvydas Ignotas wrote:

> Soft reset seems to recover from this so there is no problem, but you
> can't reset before every suspend so a workaround is still needed..

OK, that's good.

> Well as long as it works it's good for me, although it'll bloat the
> code a bit compared to just changing the data. Should I attempt an
> implementation?

Please do.  I'd be shocked if it comes out to more than four or five extra 
ARM instructions...


- Paul
