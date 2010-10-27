From: eric@eukrea.com (=?ISO-8859-15?Q?Eric_B=E9nard?=)
Date: Wed, 27 Oct 2010 15:33:07 +0200
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <20101027132213.GJ6017@pengutronix.de>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>	<20101027082958.GA6797@angua.secretlab.ca>	<20101027090921.GB8554@pengutronix.de>	<20101027102253.GA7822@angua.secretlab.ca>
	<20101027132213.GJ6017@pengutronix.de>
Message-ID: <4CC82A13.8000909@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 27/10/2010 15:22, Sascha Hauer a ?crit :
 > That's a way we can go but only if the common name is not MX5 or MX5x.
 > We've done it with the mx21/27 and it failed when the mx25 came out
 > which was completely incompatible. Since then everybody looking at
 > the code must know that mx2x is mx21/27 but not mx25. I suggest
 > something like MX513 instead.
 >
MX513 is the partnumber of a member of the i.MX51 family so that's maybe not 
the best choice.
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=i.MX513

Eric
