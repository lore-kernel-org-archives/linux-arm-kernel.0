From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 26 Nov 2014 18:15:19 +0100
Subject: [PATCH v2 2/5] i2c: davinci: query STP always when NACK is
 received
In-Reply-To: <5476005A.6090207@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-3-git-send-email-grygorii.strashko@ti.com>
 <20141126155711.GL4431@pengutronix.de> <5476005A.6090207@ti.com>
Message-ID: <20141126171519.GP4431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grygorii,

On Wed, Nov 26, 2014 at 06:31:22PM +0200, Grygorii Strashko wrote:
> On 11/26/2014 05:57 PM, Uwe Kleine-K?nig wrote:
> >I don't understand your use of "query" in the subject and later in the
> >commit log. Do you mean "send"?
> 
> will change to "generate". Ok?
yes that would be better understandable

> Can I assume that you are ok with this patch in general?
Yeah, your argument that being able to send a Sr is not sensible made
sense to me. If Wolfram is happy with your patch so am I.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
