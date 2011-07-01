From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 1 Jul 2011 19:26:03 +0200
Subject: [PATCH 2/8] at91: factorize at91 interrupts init to soc
In-Reply-To: <201107011747.40399.arnd@arndb.de>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-2-git-send-email-plagnioj@jcrosoft.com>
	<201107011747.40399.arnd@arndb.de>
Message-ID: <20110701172603.GH14408@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:47 Fri 01 Jul     , Arnd Bergmann wrote:
> On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > they are the same except the default priority
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> 
> Very nice!
tks

we can do so because we have detect the soc type :)

Best Regards,
J.
