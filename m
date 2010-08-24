From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Tue, 24 Aug 2010 19:13:50 +0200
Subject: [PATCH 0/2] fix mx35fb display mappings
In-Reply-To: <1282663623-8404-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
	<1282663623-8404-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <4C73FDCE.9080808@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

Le 24/08/2010 17:27, Michael Grzeschik a ?crit :
> This patches introduce a fix for the display mappings
> in the mx35 framebuffer. It also sets the platformspecific
> display mapping for the mx35_3ds development board's tft panel
> added with this patch:
>
won't this patch break other platforms which are using mx3fb ?

Eric
