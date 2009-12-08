From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Dec 2009 23:07:24 +0100
Subject: [PATCH 1/2 RESEND#2] i2c/pxa: remove unused macro
In-Reply-To: <20091208224456.0baf422b@hyperion.delvare>
References: <1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258658141-30340-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091208211810.GB13706@pengutronix.de>
	<20091208224456.0baf422b@hyperion.delvare>
Message-ID: <20091208220724.GA14696@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Tue, Dec 08, 2009 at 10:44:56PM +0100, Jean Delvare wrote:
> On Tue, 8 Dec 2009 22:18:10 +0100, Uwe Kleine-K?nig wrote:
> > Hi Jean,
> > 
> > On Thu, Nov 19, 2009 at 08:15:40PM +0100, Uwe Kleine-K?nig wrote:
> > > Commit
> > > 
> > > 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
> > > 
> > > removed all uses of eedbg, so the definition can go, too.
> > do you have comments to my patches?  I think they should go in via your
> > tree.
> 
> I think you should read MAINTAINERS again.
Ah, so the maintainer is Ben Dooks, but the tree seems to be your's.

So I assume you take it when Ben give's his S-o-b or Ben has write
access to the tree?

Ben, what do you think about my patches?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
