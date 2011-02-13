From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Feb 2011 22:18:55 +0100
Subject: [PATCHv3] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1297545419-31181-1-git-send-email-GNUtoo@no-log.org>
References: <20110211213348.GJ27982@pengutronix.de>
	<1297545419-31181-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <20110213211855.GC13279@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Sat, Feb 12, 2011 at 10:16:59PM +0100, Denis 'GNUtoo' Carikli wrote:
> This work was based on bug-linux-2.6.30.patch that can be found
>   in buglabs's svn here:
>   svn://bugcamp.net/bug/branches/izzy/experimental
> 
> Note that the hardware schematics and documentations can be obtained
>   here: http://www.bugcommunity.com/wiki/index.php/BUGbase
> 
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
The patch looks good to me now.  If you want to make me still more
happy, there are still two minor things to optimize:

 - don't reference the history of the patch in the commit log.  This is
   quite useless once the commit made it into Linus' tree.  (The info
   might still be interesting, but then put it after the tripple dash
   below.  Then it won't make it into git.)
 - there is a trailing empty line in bug_board_init()

Maybe Sascha can fix this up when taking the patch?  (Assuming the
others are happy now, too of course.)

And I wonder there is no copyright statement by you in
arch/arm/mach-mx3/mach-bug.c, maybe because you consider your changes
too minor to be relevant?  (INAL and I don't know who to value your
contribution.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
