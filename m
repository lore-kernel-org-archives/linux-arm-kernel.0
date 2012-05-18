From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 May 2012 08:00:56 +0200
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
Message-ID: <20120518060056.GB3710@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 01:07:07AM -0300, Fabio Estevam wrote:
> initlevel:7=late, 20 registered initcalls
> VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
> turn off boot console earlycon
> 
> How can we prevent the "turn off boot console earlycon" to happen?
pass

	keep_bootcon

as kernel parameter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
