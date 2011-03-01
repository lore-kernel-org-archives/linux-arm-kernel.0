From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Mar 2011 20:37:34 +0000
Subject: [PATCH 1/2] ARM: mx3/cpuimx35: fix build failure
In-Reply-To: <1299011459-18200-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301203018.GY22310@pengutronix.de>
	<1299011459-18200-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110301203734.GF27107@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 09:30:58PM +0100, Uwe Kleine-K?nig wrote:
> It seems vim's autocompletion played tricks on me without me noticing.

Every time I hear the word 'autocompletion' it's always associated with
the wrong thing happening.  I really don't know why people even bother
with 'autocompletion' because it seems to go wrong very often.  Whether
it be with code, or with nicknames on IRC...

The only autocompletion that I've seen which works right and avoids these
kinds of issues is in things like bash, where it won't autocomplete unless
there is exactly one completion available.
