From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Mar 2010 10:29:46 +0100
Subject: [PATCH v2] CLKDEV: return from clk_find as soon as we get
	maching clk
In-Reply-To: <4B8E4F93.6030200@st.com>
References: <1267598907-7095-1-git-send-email-viresh.kumar@st.com>
	<20100303103342.GA7952@pengutronix.de> <4B8E4F93.6030200@st.com>
Message-ID: <20100304092946.GD5011@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > Does this mean you understood Russell's hint?
> 
> Truly speaking i didn't get it completely, but i think Russsell is 
> referring to multiple return points from a function.
> 
> Russell, Am I getting it correctly ?
> 
> > Did you test the differences your patch results in for the generated
> > code?
> 
> I think they are essentially same, we now just have a single return point
> in the new patch.
Well then,

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
