From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 Apr 2014 12:07:34 +0200
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <20140404165559.GE9007@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <20140404165559.GE9007@google.com>
Message-ID: <1397556454.4574.13.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Am Freitag, den 04.04.2014, 10:55 -0600 schrieb Bjorn Helgaas:
> On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
> rebase and rename it after v3.15-rc1, and I think we can squeeze it into
> v3.15 shortly after that.  Thanks.
> 

Are you still planning to push this into 3.15, or has this slipped to
3.16?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
