From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 20:31:55 +0000
Subject: [PATCH v5] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <20120316131129.GH7757@game.jcrosoft.org>
References: <1331903003-14045-1-git-send-email-sr@denx.de>
 <20120316131129.GH7757@game.jcrosoft.org>
Message-ID: <201203162031.56051.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Acked-by: Viresh Kumar <viresh.kumar@st.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> 
> I'm not a fan to have non Documented DT binding butthey are basic so ok
> 

I've applied the patch to the next/dt2 branch now, which means it
will get sent later than the first batch of dt conversions and
we have some time to let this get tested in linux-next, but the
plan is still to have it in v3.4.

With this, it seems that SPEAr600 will be the surprise winner in the
race to have the first platform that removes all of its board files
and replaces them with DT probing ;-)

Thanks everyone!

	Arnd
