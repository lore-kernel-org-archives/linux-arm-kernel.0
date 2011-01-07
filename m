From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 7 Jan 2011 10:49:25 +0100
Subject: [PATCH 0/2] Common struct clk implementation, v10
In-Reply-To: <4D266D6C.7050005@fluff.org>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<4D266D6C.7050005@fluff.org>
Message-ID: <20110107094925.GC25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Fri, Jan 07, 2011 at 01:33:32AM +0000, Ben Dooks wrote:
> On 05/01/11 03:51, Jeremy Kerr wrote:
> > Hi all,
> > 
> > These patches are an attempt to allow platforms to share clock code. At
> > present, the definitions of 'struct clk' are local to platform code,
> > which makes allocating and initialising cross-platform clock sources
> > difficult, and makes it impossible to compile a single image containing
> > support for two ARM platforms with different struct clks.
> 
> no, it doesn't actually. you could do run-time link and select
> the right arch support.
does that mean you're against the patch set?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
