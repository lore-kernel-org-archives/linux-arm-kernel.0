From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 23 Feb 2011 09:15:39 +0100
Subject: [PATCH] wip: convert imx27 to common struct clk
In-Reply-To: <4D648A3D.7020402@codeaurora.org>
References: <1298256658.861611.43913489619.0.gpush@pororo>
	<1298417599-23522-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4D648A3D.7020402@codeaurora.org>
Message-ID: <20110223081539.GM22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravana,

On Tue, Feb 22, 2011 at 08:17:01PM -0800, Saravana Kannan wrote:
> On 02/22/2011 03:33 PM, Uwe Kleine-K?nig wrote:
> >I had to degrade one WARN_ON to WARN_ON_ONCE in drivers/clk/clk.c to
> >actually make it work.  Otherwise console output results in a warning
> >that results in console output ...
> 
> You won't be able to do mainline the WARN_ON_ONCE because that will
> only warn for the first clock that violates whatever condition it's
> warning about.
I wonder if it is more sensible while the warning is new.  But I don't
care much because I'm going to fix the serial driver before switching.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
