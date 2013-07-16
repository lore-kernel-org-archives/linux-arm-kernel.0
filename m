From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 09:48:00 -0600
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1373968758.4327.17.camel@pizza.hi.pengutronix.de>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <1373968758.4327.17.camel@pizza.hi.pengutronix.de>
Message-ID: <51E56B30.7030302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 03:59 AM, Philipp Zabel wrote:
...
> Deferred probing is fine, but it'd be nice to keep the probe deferral
> loops to a minimum where possible and/or reasonable.

I agree, but manually selecting initcalls for drivers is not the
solution. See my other email.
