From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 17:49:26 +0200
Subject: [PATCH 3/8] at91: remove AT91_DBGU offset from dbgu register macro
In-Reply-To: <1309502682-16897-3-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-3-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201107011749.26848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Please add a changelog that describes why you do this. The old code looks
just as well as the new one.

	Arnd
