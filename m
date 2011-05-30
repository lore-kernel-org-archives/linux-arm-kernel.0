From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2011 14:51:58 +0200
Subject: SPEAr320: Add pwm support
In-Reply-To: <20110530121030.GA314@e-circ.dyndns.org>
References: <cover.1306739836.git.viresh.kumar@st.com>
	<20110530114405.GD23771@pengutronix.de>
	<20110530121030.GA314@e-circ.dyndns.org>
Message-ID: <201105301451.58964.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 May 2011, Kurt Van Dijck wrote:
> I was not aware of such. Me too did a generic PWM implementation (not published yet)
> but with 2 differences (apart from code quality I guess):
> 
> * do pwm input too (pwm measurement) since we have some kind of
>   dedicated PWM in a remote CPU over i2c, that can measure them too.
> * /dev interface
> 
> Is this something usefull to try adding?

I'd leave that for later. In particular, user interface design is hard, so
let's consolidate the drivers first and then look at possible extensions.

	Arnd
