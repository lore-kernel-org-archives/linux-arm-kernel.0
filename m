From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 18 Feb 2011 06:31:38 +0200
Subject: [PATCH 4/4] mtd: OneNAND: OMAP2: increase multiblock erase
	verify timeout
In-Reply-To: <20110217234603.GI20795@atomide.com>
References: <1297068421-14430-1-git-send-email-adrian.hunter@nokia.com>
	<1297068421-14430-5-git-send-email-adrian.hunter@nokia.com>
	<20110217234603.GI20795@atomide.com>
Message-ID: <1298003498.2735.4.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2011-02-17 at 15:46 -0800, Tony Lindgren wrote:
> * Adrian Hunter <adrian.hunter@nokia.com> [110207 00:45]:
> > From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> > 
> > The current multiblock erase verify read timeout 100us is the maximum
> > for none-error case. If errors happen during multibock erase then
> > the specification recommends to run multiblock erase verify command
> > with maximum timeout 10ms (see specs. for KFM4G16Q2A and KFN8G16Q2A).
> > 
> > For the most common non-error case we wait 100us in udelay polling
> > loop. In case of timeout the interrupt mode is used to wait for the
> > command end.
> > 
> > Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> 
> I'll queue this series. Anybody from MTD list care to ack this patch?

Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
